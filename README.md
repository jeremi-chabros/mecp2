# The Mecp2 Project 

![Spikes](https://i.imgur.com/MKBPf8d.gif) ![Dynamic heatmap](https://i.imgur.com/sPkRTtE.gif)

The analysis here is divided into those based on `R` and those based on `matlab`, the main script to run for `R` is `main.Rmd`, the main script to run for `matlab` is `main.mat`, with the necessary functions stored inside `mat_functions`, therefore, add that to path. Both scripts will ask you to select a folder containing the `h5` and/or `.mat` files you want to analyse.
  
## Workflow for R analysis 

### Requirements

- computer running unix (Mac or Linux)
- Matlab (for converting raw `.mcd` files to `.h5` files with spikes only)
- A suitable `C` compiler in Matlab (2017 matlab doens't seem to work on my computer for some reason, but it may be just me. It worked when I used an older versin of matlab/C compiler.)
- R and RStudio (for spike analysis)
- Stephen Eglen code and packages (need to give more details on this)

### Overview

*****

- we start with the raw `.mcd` files 
- we run Prez's code to get only spikes (assuming you are doing spike analysis, if you want to do oscillation stuff, see workflow for matlab analysis. Alternatively, you can write/find code for oscillation analysis in `R`.)
- currenlty we don't do spike sorting, if you want to do that, look into `WaveClus`
- we then use Eglen's code (and some code written by myself), for spike anlaysis

*****


The steps from the recorded data to feature matrix X should be the following: 

- record and get .mcd files (usually 12 minutes long, about 2GB per file)
- use `WaveClus` (Prez's code) for spike detection, this will create h5 files that have the detected spikes (matlab, unix only)
- Run Eglen's code in to get features (R)
- may need to look into `something` for spike sorting (not sure if Eglen's code require spikes to be sorted or not)



alternative way is to use `MCRack` (windows only), seems to suport most of the data processing mentioned above but not sure why Eglen didn't use them. 

### Running Prez's code for spike detection 


- raw data = `.mcd` file 
- Prez wrote code to find spike times, this is converted to HDF5 format (the code only works on Unix systems)
    + https://github.com/przemyslawj/mcdtools
    + Klusta mentioned in dependencies but not needed, `WaveClus` is sufficient
- saved data fields described in the paper *A data repository and analysis framework for spontaneous neural activity recordings in developing retina*
    + names should be intuitive enough so no need to study in detail

The instructions for running Prez's code is in the following link: 
https://github.com/przemyslawj/mcdtools 
But I will reiterate them here just in case. 

Steps: 

- Download `waveclus` in your linux operating system (you know what I mean, don't talk to me about GNU/Linux)

```
wget https://github.com/csn-le/wave_clus/archive/testing.zip
unzip wave_clus-testing.zip
```

- put all the `.mcd` files you want to convert to `h5` into one folder 
- make sure the file names are in the format described below 
- open `matlab`
- change directory to your "project folder" (for me, I created a folder called "The Mecp2 Project" and put everything relating to the project inside). 
    + Put the `mcdtools-master` folder into your project folder 
    + Put the folder containing your `.mcd` files in your project folder 
    + ie. your project folder should now contain the folders `mcdtools-master` and whatever name of the folder containing your `.mcd` files 
- add everything in the the `mcdtools-master` to path, (including subfolders)
- add your folder containing `.mcd` files to path 


#### .mcd file format for Prez's code

Note that the file format has to be this: 

```
{TYPE}_{DATE}-{MEA_ID}_DIV{DAY_IN_VITRO}.mcd
```

Where:

- TYPE is the condition distinguishing the recordings, e.g. KO or WT,
- DATE is the date of culture initiation in DD_MM_YY format, e.g. 03_05_17
- MEA_ID is in [1-9][A-Z] format where the digit corresponds to a pup ordinal and the letter is the ordinal of the dish initiated from that pup, e.g. 4C
- DAY_IN_VITRO - DIV of the culture during the recording. Note that two digits are expected, ie. if the culture is two days in vitro, then write 02 instead of 2. 


you may find that some previous file format is in the form: 

tc042_d24.mcd



# Results in pictures 

A quick summary of the progress so far, in figures. 

Overview of raw data and detected spikes

![Raw Plot](https://i.imgur.com/jjwS3sH.png)


Overview of spike activity in electrodes 

![spike count heatmap](https://i.imgur.com/qZ2Y0t5.png)

Spike distribution 

![Spike count histogram](https://i.imgur.com/o4ZoQqC.png)


Network weighted by covariance 

![network](https://i.imgur.com/dvJvZvZ.png)



Effective Rank 

![Effective Rank](https://i.imgur.com/vmvzYF2.png)


# Comparing spike detection algorithms 


Note that Prez's algorithm is based on `Wave_Clus`.  

![Imgur](https://i.imgur.com/w13eNTl.png)

A close look at what's happening 

![Imgur](https://i.imgur.com/NyVnTGa.png)

Tuning thresholds 

![Imgur](https://i.imgur.com/GgsBTHN.png)

# Work in progrss 

- better networks
- network anlaysis 
- auto and cross-correlation 
- embed interactive plotly histogram 
- Gaussian Process Classification, Feature Selection



# Resources 

Python library for electrophysiological signals analysis 
http://elephant.readthedocs.io/en/0.2.0/index.html

Spike train analysis with R 
https://cran.r-project.org/web/packages/STAR/STAR.pdf



