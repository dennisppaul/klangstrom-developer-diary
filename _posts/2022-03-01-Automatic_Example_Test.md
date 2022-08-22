---
layout: post
title:  "Automatic Example Test"
date:   2022-03-01 08:00:00 +0100
---

![Automatic_Example_Test](/assets/2022-03-01-Automatic_Example_Test.png)   

i have updated most examples now. in the process i have also created a nifty shell script ( `example-testing.sh` ) which uses the Arduino CLI to compile and upload ( i.e run ) all examples in the example folders. it is also capable of reporting if a sketch failed to compile or upload ( `COMPILE:FAIL + UPLOAD:FAIL` ).

```zsh
#! /bin/zsh

ARDUINO_CLI=/usr/local/bin/arduino-cli
TIMEOUT=/usr/local/bin/timeout
TEST_DURATION=15
FAILURE_COUNTER=0

###############################################################################

OPT_COMPILE="COMPILE"
OPT_UPLOAD="UPLOAD"
BASE_COLOR=23

if [[ "$TERM" != "dumb" ]]; then
    COLOR_NORM=$(tput sgr0)
    COLOR_OK=$(tput setaf 2)
    COLOR_FAIL=$(tput setaf 1)
fi

###############################################################################

print_section() {
    echo
    echo "++++++++++++++++++++++++++++++++++++++++++"
    echo "+++ "$1 | tr a-z A-Z
    echo "++++++++++++++++++++++++++++++++++++++++++"
    echo
}

run_test() {
	if [[ "$3" == $OPT_COMPILE ]]; then
	   echo -n $OPT_COMPILE
	else
	   echo -n $OPT_UPLOAD
	fi
	
	if [ -z "$4" ]; then
		if [[ "$3" == $OPT_COMPILE ]]; then
			arduino-cli compile -b $1 -p . $2 > /dev/null 2>&1
		else
			arduino-cli compile -b $1 -u -p . $2 > /dev/null 2>&1
		fi
		RESULT_VALUE=$?
		OK_VALUE=0
	else
		if [[ "$3" == $OPT_COMPILE ]]; then
			arduino-cli compile -b $1 -p . $2 > /dev/null 2>&1
			RESULT_VALUE=$?
			OK_VALUE=0
		else
			timeout --preserve-status $4 arduino-cli compile -b $1 -u -p . $2 > /dev/null 2>&1
			RESULT_VALUE=$?
			OK_VALUE=143
		fi
	fi
	if [ $RESULT_VALUE -eq $(($OK_VALUE)) ]; then
	   echo -n $COLOR_OK":OK"
	else
	   echo -n $COLOR_FAIL":FAIL"
	   FAILURE_COUNTER=$((FAILURE_COUNTER+1));
	fi
	echo -n $COLOR_NORM
}

###############################################################################

print_section "check for Arduino CLI"

$ARDUINO_CLI version

###############################################################################

print_section "compile and upload examples"

for FILE in **/*.ino
do
	echo    "+++ TEST '"$FILE"'"

	echo -n "    "
	echo -n "DESKTOP (SDL)    > "
	run_test klangstrom:desktop:sdl $FILE $OPT_COMPILE $TEST_DURATION
	echo -n " + "
	run_test klangstrom:desktop:sdl $FILE $OPT_UPLOAD  $TEST_DURATION
	echo

	echo -n "    "
	echo -n "MCU (KLST_SHEEP) > "
	run_test klangstrom:stm32:Klangstrom:pnum=KLST_SHEEP $FILE $OPT_COMPILE
	echo -n " + "
	run_test klangstrom:stm32:Klangstrom:pnum=KLST_SHEEP $FILE $OPT_UPLOAD
	echo
done

echo "+++ NUMBER OF EXAMPLES FAILED: " $FAILURE_COUNTER
```

this was the output from yesterday’s run ( i have fixed a few examples in the meantime ;) ):

```zsh
++++++++++++++++++++++++++++++++++++++++++
+++ CHECK FOR ARDUINO CLI
++++++++++++++++++++++++++++++++++++++++++

arduino-cli  Version: 0.21.1 Commit: 9fcbb392 Date: 2022-02-23T16:42:40Z

++++++++++++++++++++++++++++++++++++++++++
+++ COMPILE AND UPLOAD EXAMPLES
++++++++++++++++++++++++++++++++++++++++++

+++ TEST 'klang/ExampleADCtoDAC/ExampleADCtoDAC.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleADSR/ExampleADSR.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleADSRTriggered/ExampleADSRTriggered.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleChorus/ExampleChorus.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleDelay/ExampleDelay.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleDistortion/ExampleDistortion.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleEnvelope/ExampleEnvelope.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleEnvelopeSimple/ExampleEnvelopeSimple.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleEnvelopeTriggered/ExampleEnvelopeTriggered.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleFFT/ExampleFFT.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleFilters/ExampleFilters.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleKernel/ExampleKernel.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleKernelBlockMulti/ExampleKernelBlockMulti.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleKernelBlockStereo/ExampleKernelBlockStereo.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleLFOs/ExampleLFOs.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleMixer2/ExampleMixer2.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleMixer32/ExampleMixer32.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleMixer4/ExampleMixer4.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleMixer4Stereo/ExampleMixer4Stereo.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleMixerMulti/ExampleMixerMulti.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleMixerMultiStereo/ExampleMixerMultiStereo.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleMute/ExampleMute.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleNoise/ExampleNoise.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleOscillators/ExampleOscillators.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExamplePatch/ExamplePatch.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExamplePatch16/ExamplePatch16.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExamplePhaser/ExamplePhaser.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExamplePortamento/ExamplePortamento.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleRamp/ExampleRamp.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleRampTriggered/ExampleRampTriggered.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleSampler/ExampleSampler.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleSamplerUI8/ExampleSamplerUI8.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleSharedWavetable/ExampleSharedWavetable.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleSplitter/ExampleSplitter.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleVCAwithLFO/ExampleVCAwithLFO.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/ExampleWaveshaper/ExampleWaveshaper.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/extensions/ExampleReverb/ExampleReverb.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/extensions/ExampleTextToSpeechSAM/ExampleTextToSpeechSAM.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klang/extensions/ExampleVocoder/ExampleVocoder.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/ExampleEvents/ExampleEvents.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/applications/8BitDrumMachine/8BitDrumMachine.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/applications/AudioFilePlayer/AudioFilePlayer.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/applications/DrumMachine/DrumMachine.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/applications/FFTSingAlong/FFTSingAlong.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/applications/GranularDisintegration/GranularDisintegration.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/applications/HappyPatternMachine/HappyPatternMachine.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/applications/HelloJacob/HelloJacob.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/board/ExampleAnalogRead/ExampleAnalogRead.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/board/ExampleBeat/ExampleBeat.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/board/ExampleBeat2/ExampleBeat2.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/board/ExampleBlink/ExampleBlink.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/board/ExampleManualInputOutputLevels/ExampleManualInputOutputLevels.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/board/ExampleMeasuringPerformance/ExampleMeasuringPerformance.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/board/ExamplePassThrough/ExamplePassThrough.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/board/ExampleProgrammerReset/ExampleProgrammerReset.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/board/ExampleReadSDCard/ExampleReadSDCard.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/board/ExampleSavingPresets/ExampleSavingPresets.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/board/ExampleToolPrintUID/ExampleToolPrintUID.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/peripherals/card/ExampleListFiles/ExampleListFiles.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/peripherals/card/ExamplePlayWAVFile/ExamplePlayWAVFile.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/peripherals/card/ExampleWAVFileInfo/ExampleWAVFileInfo.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/peripherals/display/ExampleDisplayDrawAudioBuffer/ExampleDisplayDrawAudioBuffer.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/peripherals/display/ExampleDisplayDrawPrimitives/ExampleDisplayDrawPrimitives.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/peripherals/display/ExampleDisplayFullscreenAnimation/ExampleDisplayFullscreenAnimation.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'klangstrom/peripherals/encoders/ExampleRotaryEncoder/ExampleRotaryEncoder.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/peripherals/serial/ExampleDataSendAndReceive/ExampleDataSendAndReceive.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'klangstrom/peripherals/serial/ExampleSerialSendAndReceive/ExampleSerialSendAndReceive.ino'
    DESKTOP (SDL)    > COMPILE:FAIL + UPLOAD:FAIL
    MCU (KLST_SHEEP) > COMPILE:FAIL + UPLOAD:FAIL
+++ TEST 'strom/ExampleStromEvents/ExampleStromEvents.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'strom/ExampleStromEventsInKlang/ExampleStromEventsInKlang.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
+++ TEST 'strom/ExampleStromNodeStructure/ExampleStromNodeStructure.ino'
    DESKTOP (SDL)    > COMPILE:OK + UPLOAD:OK
    MCU (KLST_SHEEP) > COMPILE:OK + UPLOAD:OK
```
