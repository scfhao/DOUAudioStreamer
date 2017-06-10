音频异常结束测试

使用DOUAudioStreamer在线播放采样率非44100的自制mp3时，会有异常提前结束问题。

正常商业音频信息举例：
(AudioStreamBasicDescription) $0 = {
  mSampleRate = 44100
  mFormatID = 778924083
  mFormatFlags = 0
  mBytesPerPacket = 0
  mFramesPerPacket = 1152
  mBytesPerFrame = 0
  mChannelsPerFrame = 2
  mBitsPerChannel = 0
  mReserved = 0
}
异常音频举例：
(AudioStreamBasicDescription) $0 = {
  mSampleRate = 8000
  mFormatID = 778924083
  mFormatFlags = 0
  mBytesPerPacket = 0
  mFramesPerPacket = 576
  mBytesPerFrame = 0
  mChannelsPerFrame = 1
  mBitsPerChannel = 0
  mReserved = 0
}
改进后的
AudioStreamBasicDescription( 22050, .mp3, 0, 0, 576, 0, 2, 0, 0 )
( 8000, .mp3, 0, 0, 576, 0, 1, 0, 0 )


-> ( 44100, lpcm, 12, 4, 1, 4, 2, 16, 0 )


bufferSize = 35280, outputSizePerPacket = 4, numOutputPackets = 8820




































