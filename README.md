# Muse_LSL_Environments


to setup a new mac:
hot corner
screen saver
energy saver
name
dock 


download:
https://github.com/kylemath/muse-lsl

get-pip.py
pip install matplotlib

touch ~/.bash_profile; open ~/.bash_profile
export DYLD_FALLBACK_LIBRARY_PATH=/usr/lib:$DYLD_FALLBACK_LIBRARY_PATH 

----
Anaconda3-5.0.1-MacOSX-x86_64
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
python muse-lsl.py â-name Muse-0A17
-muse

source activate muse-lsl-env
cd dropbox/experiments/matlab/muse-lsl-master
python lsl-viewer-V2.py


source activate psychopyenv
cd dropbox/experiments/matlab/muse-lsl-master
python stimulus_presentation/generate_Visual_P300.py -d 300 & python lsl-record.py -d 300

