# Run this code from your directory with all the wav files in it.
# ../run_convert_to_ogg.sh
mkdir ogg
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

# 0bb6bbc5a53814fc703cd76ddf818146  ../../marge_voice.tar.gz