//
//  SOAudio.m
//  DOUASDemo
//
//  Created by xueyi on 2017/6/8.
//  Copyright © 2017年 Douban Inc. All rights reserved.
//

#import "SOAudio.h"

NSString * NSStringFromAudioStreamBasicDescription(AudioStreamBasicDescription des) {
    return [NSString stringWithFormat:@"AudioStreamBasicDescription( %.0lf, %@, %u, %u, %u, %u, %u, %u, %u )", des.mSampleRate, NSStringFromAudioFormatID(des.mFormatID), des.mFormatFlags, des.mBytesPerPacket, des.mFramesPerPacket, des.mBytesPerFrame, des.mChannelsPerFrame, des.mBitsPerChannel, des.mReserved];
}

NSString * NSStringFromAudioFormatID(AudioFormatID fmt) {
    switch (fmt) {
        case kAudioFormatLinearPCM:                 return @"lpcm";
        case kAudioFormatAC3:                       return @"ac-3";
        case kAudioFormat60958AC3:                  return @"cac3";
        case kAudioFormatAppleIMA4:                 return @"ima4";
        case kAudioFormatMPEG4AAC:                  return @"aac ";
        case kAudioFormatMPEG4CELP:                 return @"celp";
        case kAudioFormatMPEG4HVXC:                 return @"hvxc";
        case kAudioFormatMPEG4TwinVQ:               return @"twvq";
        case kAudioFormatMACE3:                     return @"MAC3";
        case kAudioFormatMACE6:                     return @"MAC6";
        case kAudioFormatULaw:                      return @"ulaw";
        case kAudioFormatALaw:                      return @"alaw";
        case kAudioFormatQDesign:                   return @"QDMC";
        case kAudioFormatQDesign2:                  return @"QDM2";
        case kAudioFormatQUALCOMM:                  return @"Qclp";
        case kAudioFormatMPEGLayer1:                return @".mp1";
        case kAudioFormatMPEGLayer2:                return @".mp2";
        case kAudioFormatMPEGLayer3:                return @".mp3";
        case kAudioFormatTimeCode:                  return @"time";
        case kAudioFormatMIDIStream:                return @"midi";
        case kAudioFormatParameterValueStream:      return @"apvs";
        case kAudioFormatAppleLossless:             return @"alac";
        case kAudioFormatMPEG4AAC_HE:               return @"aach";
        case kAudioFormatMPEG4AAC_LD:               return @"aacl";
        case kAudioFormatMPEG4AAC_ELD:              return @"aace";
        case kAudioFormatMPEG4AAC_ELD_SBR:          return @"aacf";
        case kAudioFormatMPEG4AAC_ELD_V2:           return @"aacg";
        case kAudioFormatMPEG4AAC_HE_V2:            return @"aacp";
        case kAudioFormatMPEG4AAC_Spatial:          return @"aacs";
        case kAudioFormatAMR:                       return @"samr";
        case kAudioFormatAMR_WB:                    return @"sawb";
        case kAudioFormatAudible:                   return @"AUDB";
        case kAudioFormatiLBC:                      return @"ilbc";
        case kAudioFormatDVIIntelIMA:               return @"DVIIntelIMA";
        case kAudioFormatMicrosoftGSM:              return @"MicrosoftGSM";
        case kAudioFormatAES3:                      return @"aes3";
        case kAudioFormatEnhancedAC3:               return @"ec-3";
        default:                                    return @"Undefined";
    }
}

@implementation SOAudio

@end
