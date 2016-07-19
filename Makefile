# This cannot be moved into internal makefile
# base_path = test/prototyping/hdl/test
base_path = components/cordic/hw/hdl/test

all:
	# cd ${base_path}/;
	# python ${base_path}/test_main.py
	cd ${base_path}/;python ./test_main.py



	# git/hwpy/components/cordic/hw/hdl/test/test_main.py make results.xml
	# make[1]: Entering directory '/home/gaspar/git/hwpy/components/cordic/hw/hdl/test/rtl_sim'
