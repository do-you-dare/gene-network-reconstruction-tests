all: iota/IOTA.R

iota/IOTA.zip: iota/
	wget http://tocsy.pik-potsdam.de/IOTA/IOTA.zip
	mv IOTA.zip iota/

iota/:
	mkdir iota/

iota/IOTA.R: iota/IOTA.zip
	cd iota && unzip IOTA.zip

clean:
	rm -rf iota
