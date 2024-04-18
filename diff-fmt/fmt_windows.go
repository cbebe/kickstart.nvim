package main

import "os/exec"

func format() *exec.Cmd {
	return exec.Command("lua", "fnlfmt", "-")
}
