data: octicons-data.el

octicons-data.el:
	ruby author/getfontinfo.rb > $@
