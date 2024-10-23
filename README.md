# valetudo_voice_pack_marge_simpson
This is a voice pack of all the Dreame D10S Plus messages repeated in the synthesized voice of Marge Simpson. These messages were created with an online voice synthesizer.

I just installed Valetudo on my D10S Plus and then I found this GitHub repo for installing a voice pack: https://gist.github.com/xmesaj2/33af535ee9eb37c947135042c4ebb4c0

It looked pretty straight forward but wasn't for my specific vacuum. I compared the numbered ogg files in the repo with the ogg files on my robot and there were differences on both sides!
Because of this I created my own set of ogg files using fakeyou: https://fakeyou.com/tts turns out, they have an excellent voice model of Marge Simpson.

I "borrowed" the following sequence from xmesaj2's repo and tweaked it slightly for my process. This time I skipped ngrok because it wanted me to create an account... since I'm only hosting this locally to download the file, I just used the python http.server - it worked like a charm!

1. Root
2. Install Valetudo
3. Backup files with SCP and to make a list of all of them
```console 
scp -i key.id_rsa root@192.168.1.101:/audio/EN/* backup/
```
4. Download/create your .wav files, save as `0.wav` `1.wav` etc.
https://github.com/Findus23/voice_pack_dreame/blob/main/sound_list.csv use this for reference which file is which sound to avoid listening to original files to find out
5. Normalize WAV and convert to OGG. 
I used an Ubuntu 22.04.4 LTS machine I have (install `vorbis-tools`, `ffmpeg`)
```console 
mkdir ogg
cp backup/* ogg/
filenames=(
"0"     "1"     "2"     "3"     "4"     "5"     "6"     "7"     "8"     "9"
"10"    "11"    "12"    "13"    "14"    "17"    "18"    "19"    "20"    "21"
"23"    "24"    "25"    "26"    "27"    "28"    "29"    "30"    "31"    "34"
"35"    "36"    "37"    "38"    "39"    "40"    "41"    "42"    "43"    "44"
"45"    "46"    "47"    "48"    "50"    "52"    "54"    "55"    "56"    "57"
"58"    "61"    "62"    "63"    "64"    "65"    "66"    "67"    "68"    "71"
"72"    "75"    "82"    "83"    "84"    "85"    "86"    "87"    "90"    "101"
"102"   "110"   "116"   "117"   "118"   "126"   "127"   "128"   "129"   "130"
"133"   "134"   "135"   "136"   "137"   "138"   "143"   "144"   "145"   "146"
"149"   "150"   "151"   "152"   "153"   "162"   "163"   "164"   "171"   "172"
"187"   "200"   "257"   "258"   "259"   "260"   "261"   "262"   "267"   "269"
"274"   "293"   "294"
)
for filename in ${filenames[@]}; do ffmpeg -i "${filename}.wav" -filter:a loudnorm=I=-14:LRA=1:dual_mono=true:tp=-1 "${filename}_n.wav" && oggenc "${filename}_n.wav" --output "${filename}.ogg" --bitrate 100 --resample 16000; done
rm *_n.wav
mv *.ogg ogg/
cd ogg
tar czf ../../marge_voice.tar.gz *.ogg
md5sum ../../marge_voice.tar.gz
```
6. Serve files. I used http.server
```console 
python -m http.server 8000 --bind 0.0.0.0
```
7. Open the url in web browser, right click `marge_voice.tar.gz` "copy link"
8. Go to Valetudo eg. http://192.168.1.101/#/robot/settings/misc language MARGE, hash from md5sum command -- I think it was 0bb6bbc5a53814fc703cd76ddf818146
