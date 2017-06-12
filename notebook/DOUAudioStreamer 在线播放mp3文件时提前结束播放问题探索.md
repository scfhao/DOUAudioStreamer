DOUAudioStreamer 在线播放mp3文件时提前结束播放问题探索

DOUAudioStreamer 是一个在线音乐流播放框架，源于 douban。DOUAudioStreamer 框架涵盖的内容较多，这里只对其中的音频读取部分进行分析。

## 不完整播放流程：

1. DOUAudioFileProvider 调用 DOUSimpleHTTPRequest 对音频文件进行下载。
2. 对已下载的文件部分进行内存映射。
3. 从音频文件中读取音频原始数据。
4. 将音频原始数据转换为 lpcm 数据。
5. 播放 lpcm 数据。

## 提前结束播放原因查找

在步骤 3 中使用 AudioFileReadPackets 函数读取音频包时，发生读取到的包的数量为0，即该函数的ioNumPackets参数返回为0，所以被认为已经读到音频文件的结尾，然后播放结束。

## 解决过程

1. 调整缓冲时间长度

我遇到的情况在线播放时会提前终止，但本地播放时不会出现这种情况，所以我推测可能是缓冲的数据不够播放，但我调整这里的缓冲时间，并没有起到作用，且我播放的音频文件只有400kb，现在的网络条件几乎是秒下的。

DOUAudioStreamer+Options.m 中定义了缓冲时间长度`kDOUAudioStreamerBufferTime`，默认是200毫秒。

2. 尝试替换 AudioFileReadPackets 函数。

```
extern OSStatus	
AudioFileReadPackets (	AudioFileID  					inAudioFile, 
                        Boolean							inUseCache,
                        UInt32 *						outNumBytes,
                        AudioStreamPacketDescription * __nullable outPacketDescriptions,
                        SInt64							inStartingPacket, 
                        UInt32 * 						ioNumPackets,
                        void * __nullable				outBuffer)			__OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2,__MAC_10_10, __IPHONE_2_0,__IPHONE_8_0);
```

这个函数标记为从iOS 8开始不建议使用，官方建议使用`AudioFileReadPacketData()`函数代替，我尝试改成这个方法后并没解决问题。

typedef struct {
  AudioFileID afid;							// 打开的音频文件
  SInt64 pos;								// 音频文件的读取位置
  void *srcBuffer;							// 每次从音频文件中读取数据的缓冲区
  UInt32 srcBufferSize;						// 缓冲区大小
  AudioStreamBasicDescription srcFormat;	// 原始格式
  UInt32 srcSizePerPacket;          // mBytesPerPacket（或者音频文件中包的最大大小）
  UInt32 numPacketsPerRead;         // 需要缓冲的包数
  AudioStreamPacketDescription *pktDescs;   缓冲的包信息数组
} AudioFileIO;

typedef struct {
  AudioStreamBasicDescription inputFormat;			// 从转换器中获取的源格式
  AudioStreamBasicDescription outputFormat;			// 从转换器中获取的目标格式（lpcm）

  AudioFileIO afio;									// 音频文件信息

  SInt64 decodeValidFrames;         // 对于输入格式中mBitsPerChannel为0的音频会有此属性，代表音频文件中可用帧数量

  AudioStreamPacketDescription *outputPktDescs;

  UInt32 outputBufferSize;          // 输出缓冲区大小，和输入缓存区大小相等
  void *outputBuffer;               // 输出缓冲区

  UInt32 numOutputPackets;
  SInt64 outputPos;

  pthread_mutex_t mutex;
} DecodingContext;
