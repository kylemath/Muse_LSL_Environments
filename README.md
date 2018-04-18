# Muse_LSL_Environments

This is a set of script to interface with Alex B's Muse-LSL code https://github.com/alexandrebarachant/muse-lsl
Anaconda will create two environments, one to record and view data (lsl) and one to run psychopy experiments (psychopy)
Then the scripts below can be used to run the experiments, or see the instrcutions in the baseline folder to run a baseline task


To setup a new mac:
---
hot corner
screen saver
energy saver
name
dock 

In terminal run:
get-pip.py

then (maybe not necessary):
pip install matplotlib

Modify bask profile
---

touch ~/.bash_profile; open ~/.bash_profile
export DYLD_FALLBACK_LIBRARY_PATH=/usr/lib:$DYLD_FALLBACK_LIBRARY_PATH 

Install anaconda
----
Anaconda3-5.0.1-MacOSX-x86_64 - https://repo.continuum.io/archive/Anaconda2-5.0.1-MacOSX-x86_64.pkg

The easiest way to do that is to use Anaconda. Just follow the instruction there and install Anaconda with Python 3.6, which is the one from the link.
Once Anaconda is installed, you should have conda command available in your terminal, try which conda to make sure everything is installed properly.
Then download the files attached. They list all the packages I have been using to run experiments, and conda should be able to install them automatically. For that, use `conda env create -f /path/to/environment_lsl.yml` and `conda env create -f /path/to/environment_psychopy.yml`, and make sure /path/to/â¦ leads to actual files in the directory where you have placed them. 
This creates two virtual environments, one with Python 3.6 and one with 2.7, respectively, both ready to go with the experiment. To run LSL streaming, first run `source activate muse-lsl-env` to activate Python 3.6 environment. Use also this environment for plotting, as on the tutorial. For the paradigm, in a separate terminal window first run `source activate psychopyenv` and execute a script with stimuli after. 

---

conda env create -f /path/to/environment_lsl.yml
conda env create -f /path/to/environment_psychopy.yml

---

source activate muse-lsl-env
cd dropbox/experiments/matlab/muse-lsl-master

python muse-lsl.py --name SMTX-0124
-big
python muse-lsl.py --name SMTX-0386
-small
python muse-lsl.py -name Muse-0A17
-muse

source activate muse-lsl-env
cd dropbox/experiments/matlab/muse-lsl-master
python lsl-viewer-V2.py


source activate psychopyenv
cd dropbox/experiments/matlab/muse-lsl-master
python stimulus_presentation/generate_Visual_P300.py -d 300 & python lsl-record.py -d 300


