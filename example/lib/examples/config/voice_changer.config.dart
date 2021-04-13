import 'package:agora_rtc_engine/rtc_engine.dart';

/// VoiceChangeConfig
const VoiceChangeConfig = [
  {
    'alertTitle': 'Set Chat Beautifier',
    'options': [
      {'text': 'Off', 'type': VoiceBeautifierPreset.VoiceBeautifierOff},
      {
        'text': 'FemaleFresh',
        'type': VoiceBeautifierPreset.ChatBeautifierFresh
      },
      {
        'text': 'FemaleVitality',
        'type': VoiceBeautifierPreset.ChatBeautifierVitality,
      },
      {
        'text': 'Vigorous',
        'type': VoiceBeautifierPreset.ChatBeautifierMagnetic
      },
    ],
  },
  {
    'alertTitle': 'Set Timbre Transformation',
    'options': [
      {'text': 'Off', 'type': VoiceBeautifierPreset.VoiceBeautifierOff},
      {
        'text': 'Vigorous',
        'type': VoiceBeautifierPreset.TimbreTransformationVigorous,
      },
      {'text': 'Deep', 'type': VoiceBeautifierPreset.TimbreTransformationDeep},
      {
        'text': 'Mellow',
        'type': VoiceBeautifierPreset.TimbreTransformationMellow,
      },
      {
        'text': 'Falsetto',
        'type': VoiceBeautifierPreset.TimbreTransformationFalsetto,
      },
      {'text': 'Full', 'type': VoiceBeautifierPreset.TimbreTransformationFull},
      {
        'text': 'Clear',
        'type': VoiceBeautifierPreset.TimbreTransformationClear
      },
      {
        'text': 'Resounding',
        'type': VoiceBeautifierPreset.TimbreTransformationResounding,
      },
      {
        'text': 'Ringing',
        'type': VoiceBeautifierPreset.TimbreTransformationRinging,
      },
    ],
  },
  {
    'alertTitle': 'Set Style Transformation',
    'options': [
      {'text': 'Off', 'type': AudioEffectPreset.AudioEffectOff},
      {'text': 'Pop', 'type': AudioEffectPreset.StyleTransformationPopular},
      {'text': 'R&B', 'type': AudioEffectPreset.StyleTransformationRnB},
    ],
  },
  {
    'alertTitle': 'Set Voice Changer',
    'options': [
      {'text': 'Off', 'type': AudioEffectPreset.AudioEffectOff},
      {
        'text': 'FxUncle',
        'type': AudioEffectPreset.VoiceChangerEffectUncle,
      },
      {
        'text': 'Old Man',
        'type': AudioEffectPreset.VoiceChangerEffectOldMan,
      },
      {
        'text': 'Baby Boy',
        'type': AudioEffectPreset.VoiceChangerEffectBoy,
      },
      {
        'text': 'FxSister',
        'type': AudioEffectPreset.VoiceChangerEffectSister,
      },
      {
        'text': 'Baby Girl',
        'type': AudioEffectPreset.VoiceChangerEffectGirl,
      },
      {
        'text': 'ZhuBaJie',
        'type': AudioEffectPreset.VoiceChangerEffectPigKing,
      },
      {'text': 'Hulk', 'type': AudioEffectPreset.VoiceChangerEffectHulk},
    ],
  },
  {
    'alertTitle': 'Set Room Acoustics',
    'options': [
      {'text': 'Off', 'type': AudioEffectPreset.AudioEffectOff},
      {'text': 'KTV', 'type': AudioEffectPreset.RoomAcousticsKTV},
      {'text': 'Concert', 'type': AudioEffectPreset.RoomAcousticsVocalConcert},
      {'text': 'Studio', 'type': AudioEffectPreset.RoomAcousticsStudio},
      {'text': 'Phonograph', 'type': AudioEffectPreset.RoomAcousticsPhonograph},
      {
        'text': 'Virtual Stereo',
        'type': AudioEffectPreset.RoomAcousticsVirtualStereo,
      },
      {'text': 'Spacial', 'type': AudioEffectPreset.RoomAcousticsSpacial},
      {'text': 'Ethereal', 'type': AudioEffectPreset.RoomAcousticsEthereal},
      {
        'text': '3D Voice',
        'type': AudioEffectPreset.RoomAcoustics3DVoice,
      },
    ],
  },
  {
    'alertTitle': 'Set Pitch Correction',
    'options': [
      {'text': 'Off', 'type': AudioEffectPreset.AudioEffectOff},
      {'text': 'Pitch Correction', 'type': AudioEffectPreset.PitchCorrection},
    ],
  },
];

/// FreqOptions
const FreqOptions = [
  {'text': '31Hz', 'type': AudioEqualizationBandFrequency.Band31},
  {'text': '62Hz', 'type': AudioEqualizationBandFrequency.Band62},
  {'text': '125Hz', 'type': AudioEqualizationBandFrequency.Band125},
  {'text': '250Hz', 'type': AudioEqualizationBandFrequency.Band250},
  {'text': '500Hz', 'type': AudioEqualizationBandFrequency.Band500},
  {'text': '1KHz', 'type': AudioEqualizationBandFrequency.Band1K},
  {'text': '2KHz', 'type': AudioEqualizationBandFrequency.Band2K},
  {'text': '4KHz', 'type': AudioEqualizationBandFrequency.Band4K},
  {'text': '8KHz', 'type': AudioEqualizationBandFrequency.Band8K},
  {'text': '16KHz', 'type': AudioEqualizationBandFrequency.Band16K},
];

/// ReverbKeyOptions
const ReverbKeyOptions = [
  {
    'text': 'Dry Level',
    'type': AudioReverbType.DryLevel,
    'min': -20.0,
    'max': 10.0
  },
  {
    'text': 'Wet Level',
    'type': AudioReverbType.WetLevel,
    'min': -20.0,
    'max': 10.0
  },
  {
    'text': 'Room Size',
    'type': AudioReverbType.RoomSize,
    'min': 0.0,
    'max': 100.0
  },
  {
    'text': 'Wet Delay',
    'type': AudioReverbType.WetDelay,
    'min': 0.0,
    'max': 200.0
  },
  {
    'text': 'Strength',
    'type': AudioReverbType.Strength,
    'min': 0.0,
    'max': 100.0
  },
];
