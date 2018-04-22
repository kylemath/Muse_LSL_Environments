Insructions for how to use on its own, now integrated into matlab wrapper

MUSE Headband
1)	To turn on the Muse, hold the power button located on the right ear-piece until the LED lights turn on
2)	On the Mac press ‘Command’ and ‘Space’, type ‘terminal’, and then press ‘Enter’
3)	In the terminal window that opens, type the following commands:

	source activate muse-lsl-env
  
	cd /Users/mathlab/Downloads/muse-lsl-master
  
	python muse-lsl.py --name Muse-0A17 


Wait for the laptop to connect to the Muse. If you get an error double-check everything was entered correctly, and try unplugging/plugging in the USB Bluetooth dongle
4)	Give consent form to participant to read and sign
5)	Clean Muse with alcohol swabs, as well as the participant’s forehead and backs of the ears
6)	Now with the terminal window selected, press ‘Command’ and ‘N’ to open up a second terminal window. Enter the following commands:

	source activate muse-lsl-env
  
	cd /Users/mathlab/Downloads/muse-lsl-master
  
	python lsl-viewer-V2.py

A plot will appear showing the voltages being measured by the Muse. Adjust the device (tighten, clean, add gel/water to electrodes) until each of the numbers/lines on the plot are green. At this point you can close the plot.

7)	Now open up one more terminal windows using the same ‘Command’ and ‘N’ keys mentioned above. Enter the following commands in the third terminal window:

	source activate psychopyenv
  
	cd /Users/mathlab/Desktop/Baseline
  
	python baseline_task.py & python /Users/mathlab/Desktop/Baseline/Recorder/lsl-record_muse.py

8)	The baseline experiment will take approximately 12 minutes. After the experiment, confirm the data has been saved by checking the following folders:

/Users/mathlab/Desktop/Baseline/Data/Muse

Close all open terminal windows. Remove the Muse once the experiment is finished, clean the device and the participant again, and thank the participant for their time.
