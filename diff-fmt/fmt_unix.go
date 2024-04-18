//go:build aix || darwin || dragonfly || freebsd || (js && wasm) || linux || nacl || netbsd || openbsd || solaris

package main

import "os/exec"

func format() *exec.Cmd {
	return exec.Command("fnlfmt", "-")
}
