import sys
import re

def find_resource(rtl_process, filename):
	""" get the resoource from rtl file provided rtl_process."""
	f = open(filename, "r")
	resource = ""
	for line in f:
		if re.search(r"resource:", line):
			resource = line.split(":")[1].strip()
		if re.search(r"begin :"+rtl_process+"", line):
			kind = resource.split(re.findall(r"_\d+$", resource)[0])[0]
			ff_no = re.findall(r"_\d+$", resource)[0].split('_')[1]
			resource = kind+' '+ff_no
			print(resource)
			return 0
	print("unset")
	return 0

def extract_resource_csv(filename, csvname, logname):
	""" extract all the resource from rtl file and save as csv."""
	f = open(filename, "r")
	l = open(logname, "r")
	w = open(csvname, "w")
	resource = ["unset", "unset"]
	area = ""
	for line in f:
		if re.search(r"resource:", line):
			rname = line.split(":")[1].strip()
			if re.search(r"reg", rname):
				kind = rname.split(re.findall(r"_\d+$", rname)[0])[0]
				ff_no = re.findall(r"_\d+$", rname)[0].split('_')[1]
				rname = kind+';'+ff_no
				resource[0] = rname
			if re.search(r"mux", rname):
				l.seek(0)
				for line1 in l:
					if re.search(r""+rname+"", line1):
						area = float(line1.split()[-2])/float(line1.split()[-4])
				inw = re.findall(r"\d+(?=bx)", rname)[0]
				in_no = re.findall(r"\d+(?=i)", rname)[0]
				resource[1] = rname+";"+in_no+";"+inw+";"+str(area)
		if re.search(r"begin :drive", line):
			rtl_process = line.split(":")[1].strip()
			w.write(rtl_process+","+resource[0]+","+resource[1]+"\n")
			resource = ["unset", "unset"]
	l.seek(0)
	for line in l:
		if re.search(r"cntrl", line):
			print(logname)
			print(line)
			print(line.split()[-2])
			area = float(line.split()[-2])/float(line.split()[-4])
			w.write(line.split()[-5]+",unset,"+str(area)+"\n")
	f.close()
	w.close()
	l.close()
	return 0

def extract_resource_csv_fpga(filename, csvname, logname):
	""" extract all the resource from rtl file and save as csv."""
	f = open(filename, "r")
	l = open(logname, "r")
	w = open(csvname, "w")
	resource = ["unset", "unset"]
	area = ""
	for line in f:
		if re.search(r"resource:", line):
			rname = line.split(":")[1].strip()
			if re.search(r"reg", rname):
				kind = rname.split(re.findall(r"_\d+$", rname)[0])[0]
				ff_no = re.findall(r"_\d+$", rname)[0].split('_')[1]
				rname = kind+';'+ff_no
				resource[0] = rname
			if re.search(r"mux", rname):
				l.seek(0)
				for line1 in l:
					if re.search(r""+rname+"", line1):
						area = float(line1.split()[-2])/float(line1.split()[-4])
				inw = re.findall(r"\d+(?=bx)", rname)[0]
				in_no = re.findall(r"\d+(?=i)", rname)[0]
				resource[1] = rname+";"+in_no+";"+inw+";"+str(area)
		if re.search(r"begin :drive", line):
			rtl_process = line.split(":")[1].strip()
			w.write(rtl_process+","+resource[0]+","+resource[1]+"\n")
			resource = ["unset", "unset"]
	l.seek(0)
	# for line in l:
	# 	if re.search(r"cntrl", line):
	# 		print(logname)
	# 		print(line)
	# 		print(line.split()[-2])
	# 		area = float(line.split()[-2])/float(line.split()[-4])
	# 		w.write(line.split()[-5]+",unset,"+str(area)+"\n")
	f.close()
	w.close()
	l.close()
	return 0

if __name__ == '__main__':
	if sys.argv[1] == "find_resource":
		eval(sys.argv[1])(sys.argv[2], sys.argv[3])
	if sys.argv[1] == "extract_resource_csv":
		eval(sys.argv[1])(sys.argv[2], sys.argv[3], sys.argv[4])
	if sys.argv[1] == "extract_resource_csv_fpga":
		eval(sys.argv[1])(sys.argv[2], sys.argv[3], sys.argv[4])
