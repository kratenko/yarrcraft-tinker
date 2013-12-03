MASTER = "https://github.com/kratenko/yarrcraft-tinker/blob/master/"

function get_file(remote, local)
	url = MASTER .. remote;
	rh = http.get(url)
	lh = fs.open(local)
	line = rh.readLine()
	while line do
		lh.writeLine(line)
		line = rh.readLine()
	end
	rh.close()
	fh.close()
	return true
end

get_file("README.md", "local_one")
