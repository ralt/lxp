ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SOURCES := $(wildcard src/*.lisp) $(wildcard *.asd) $(wildcard t/*.lisp)
APP_NAME=lxp

$(APP_NAME): quicklisp-manifest.txt $(SOURCES)
	@buildapp \
		--manifest-file quicklisp-manifest.txt \
		--load-system $(APP_NAME) \
		--eval '(setf *debugger-hook* (lambda (c h) (declare (ignore h)) (format t "~A~%" c) (uiop:quit -1)))' \
		--compress-core \
		--output $(APP_NAME) --entry $(APP_NAME):main

quicklisp-manifest.txt:
	@sbcl --non-interactive \
		--eval '(push #P"$(ROOT_DIR)/" asdf:*central-registry*)' \
		--eval '(ql:quickload :$(APP_NAME))' \
		--eval '(ql:write-asdf-manifest-file "quicklisp-manifest.txt")'
