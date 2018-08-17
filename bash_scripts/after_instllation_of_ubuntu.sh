sudo apt install linux-headers-$(uname -r) build-essential dkms
sudo apt install python3-pip octave maxima cmake git subversion astyle

pip3 install numpy pandas scipy matplotlib scikit-learn mglearn opencv-python jupyter QtPy beautifulsoup4 pillow
cat requirements.txt | xargs -n 1 pip3 install
