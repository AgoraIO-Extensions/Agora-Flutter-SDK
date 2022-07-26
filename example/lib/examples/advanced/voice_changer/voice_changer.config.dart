import 'package:agora_rtc_engine/agora_rtc_engine.dart';

/// VoiceChangeConfig
// ignore: constant_identifier_names
const VoiceChangeConfig = [
  {
    'alertTitle': 'Set Chat Beautifier',
    'options': [
      {'text': 'Off', 'type': VoiceBeautifierPreset.voiceBeautifierOff},
      {
        'text': 'FemaleFresh',
        'type': VoiceBeautifierPreset.chatBeautifierFresh
      },
      {
        'text': 'FemaleVitality',
        'type': VoiceBeautifierPreset.chatBeautifierVitality,
      },
      {
        'text': 'Vigorous',
        'type': VoiceBeautifierPreset.chatBeautifierMagnetic,
      },
    ],
  },
  {
    'alertTitle': 'Set Timbre Transformation',
    'options': [
      {'text': 'Off', 'type': VoiceBeautifierPreset.voiceBeautifierOff},
      {
        'text': 'Vigorous',
        'type': VoiceBeautifierPreset.timbreTransformationVigorous,
      },
      {'text': 'Deep', 'type': VoiceBeautifierPreset.timbreTransformationDeep},
      {
        'text': 'Mellow',
        'type': VoiceBeautifierPreset.timbreTransformationMellow,
      },
      {
        'text': 'Falsetto',
        'type': VoiceBeautifierPreset.timbreTransformationFalsetto,
      },
      {'text': 'Full', 'type': VoiceBeautifierPreset.timbreTransformationFull},
      {
        'text': 'Clear',
        'type': VoiceBeautifierPreset.timbreTransformationClear
      },
      {
        'text': 'Resounding',
        'type': VoiceBeautifierPreset.timbreTransformationResounding,
      },
      {
        'text': 'Ringing',
        'type': VoiceBeautifierPreset.timbreTransformationRinging,
      },
    ],
  },
  {
    'alertTitle': 'Set Style Transformation',
    'options': [
      {'text': 'Off', 'type': AudioEffectPreset.audioEffectOff},
      {'text': 'Pop', 'type': AudioEffectPreset.styleTransformationPopular},
      {'text': 'R&B', 'type': AudioEffectPreset.styleTransformationRnb},
    ],
  },
  {
    'alertTitle': 'Set Voice Changer',
    'options': [
      {'text': 'Off', 'type': AudioEffectPreset.audioEffectOff},
      {
        'text': 'FxUncle',
        'type': AudioEffectPreset.voiceChangerEffectUncle,
      },
      {
        'text': 'Old Man',
        'type': AudioEffectPreset.voiceChangerEffectOldman,
      },
      {
        'text': 'Baby Boy',
        'type': AudioEffectPreset.voiceChangerEffectBoy,
      },
      {
        'text': 'FxSister',
        'type': AudioEffectPreset.voiceChangerEffectSister,
      },
      {
        'text': 'Baby Girl',
        'type': AudioEffectPreset.voiceChangerEffectGirl,
      },
      {
        'text': 'ZhuBaJie',
        'type': AudioEffectPreset.voiceChangerEffectPigking,
      },
      {'text': 'Hulk', 'type': AudioEffectPreset.voiceChangerEffectHulk},
    ],
  },
  {
    'alertTitle': 'Set Room Acoustics',
    'options': [
      {'text': 'Off', 'type': AudioEffectPreset.audioEffectOff},
      {'text': 'KTV', 'type': AudioEffectPreset.roomAcousticsKtv},
      {'text': 'Concert', 'type': AudioEffectPreset.roomAcousticsVocalConcert},
      {'text': 'Studio', 'type': AudioEffectPreset.roomAcousticsStudio},
      {'text': 'Phonograph', 'type': AudioEffectPreset.roomAcousticsPhonograph},
      {
        'text': 'Virtual Stereo',
        'type': AudioEffectPreset.roomAcousticsVirtualStereo,
      },
      {'text': 'Spacial', 'type': AudioEffectPreset.roomAcousticsSpacial},
      {'text': 'Ethereal', 'type': AudioEffectPreset.roomAcousticsEthereal},
      {
        'text': '3D Voice',
        'type': AudioEffectPreset.roomAcoustics3dVoice,
      },
    ],
  },
  {
    'alertTitle': 'Set Pitch Correction',
    'options': [
      {'text': 'Off', 'type': AudioEffectPreset.audioEffectOff},
      {'text': 'Pitch Correction', 'type': AudioEffectPreset.pitchCorrection},
    ],
  },
];

/// FreqOptions
// ignore: constant_identifier_names
const FreqOptions = [
  {
    'text': '31Hz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand31
  },
  {
    'text': '62Hz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand62
  },
  {
    'text': '125Hz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand125
  },
  {
    'text': '250Hz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand250
  },
  {
    'text': '500Hz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand500
  },
  {
    'text': '1KHz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand1k
  },
  {
    'text': '2KHz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand2k
  },
  {
    'text': '4KHz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand4k
  },
  {
    'text': '8KHz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand8k
  },
  {
    'text': '16KHz',
    'type': AudioEqualizationBandFrequency.audioEqualizationBand16k
  },
];

/// ReverbKeyOptions
// ignore: constant_identifier_names
const ReverbKeyOptions = [
  {
    'text': 'Dry Level',
    'type': AudioReverbType.audioReverbDryLevel,
    'min': -20.0,
    'max': 10.0
  },
  {
    'text': 'Wet Level',
    'type': AudioReverbType.audioReverbWetLevel,
    'min': -20.0,
    'max': 10.0
  },
  {
    'text': 'Room Size',
    'type': AudioReverbType.audioReverbRoomSize,
    'min': 0.0,
    'max': 100.0
  },
  {
    'text': 'Wet Delay',
    'type': AudioReverbType.audioReverbWetDelay,
    'min': 0.0,
    'max': 200.0
  },
  {
    'text': 'Strength',
    'type': AudioReverbType.audioReverbStrength,
    'min': 0.0,
    'max': 100.0
  },
];
