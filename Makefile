DATA_DIR    = data

DATA_FILES  = $(DATA_DIR)/templates/dir_listing.html
DATA_FILES += $(DATA_DIR)/static/css/bootstrap-responsive.css
DATA_FILES += $(DATA_DIR)/static/css/bootstrap-responsive.min.css
DATA_FILES += $(DATA_DIR)/static/css/bootstrap.css
DATA_FILES += $(DATA_DIR)/static/css/bootstrap.min.css
DATA_FILES += $(DATA_DIR)/static/css/bootstrap.min.css
DATA_FILES += $(DATA_DIR)/static/img/glyphicons-halflings-white.png
DATA_FILES += $(DATA_DIR)/static/img/glyphicons-halflings.png
DATA_FILES += $(DATA_DIR)/static/js/bootstrap.js
DATA_FILES += $(DATA_DIR)/static/js/bootstrap.min.js

DATA_FILES += $(DATA_DIR)/version_hash

GO_FILES    = bindata.go
GO_FILES   += sbserv.go

all: sbserv


sbserv: $(GO_FILES)
	go build

$(DATA_DIR)/version_hash: .git
	git rev-parse HEAD > $(DATA_DIR)/version_hash

bindata.go: $(DATA_FILES)
	go get github.com/jteeuwen/go-bindata/...
	go-bindata data/...

clean:
	-rm -f bindata.go
	-rm -f sbserv
	-rm -f sbserv-linux-amd64 sbserv-linux-386 sbserv-freebsd-amd64 sbserv-freebsd-386 sbserv-darwin-amd64 sbserv-darwin-386

cross-compile: sbserv-linux-amd64 sbserv-linux-386 sbserv-freebsd-amd64 sbserv-freebsd-386 sbserv-darwin-amd64 sbserv-darwin-386

sbserv-linux-amd64: $(GO_FILES)
	GOOS=linux GOARCH=amd64 go build -o sbserv-linux-amd64

sbserv-linux-386: $(GO_FILES)
	GOOS=linux GOARCH=386 go build -o sbserv-linux-386

sbserv-freebsd-amd64: $(GO_FILES)
	GOOS=freebsd GOARCH=amd64 go build -o sbserv-freebsd-amd64

sbserv-freebsd-386: $(GO_FILES)
	GOOS=freebsd GOARCH=386 go build -o sbserv-freebsd-386

sbserv-darwin-amd64: $(GO_FILES)
	GOOS=darwin GOARCH=amd64 go build -o sbserv-darwin-amd64

sbserv-darwin-386: $(GO_FILES)
	GOOS=darwin GOARCH=386 go build -o sbserv-darwin-386

