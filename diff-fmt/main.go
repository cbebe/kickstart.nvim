// Because fnlfmt always writes to stdout
package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"os/exec"
)

// Runs a command that takes input from stdin and writes to stdout.
func fmtCmd(b []byte) *exec.Cmd {
	return exec.Command("fnlfmt", "-")
}

func deepCompare(sf, df io.Reader) bool {
	sscan := bufio.NewScanner(sf)
	dscan := bufio.NewScanner(df)

	for sscan.Scan() {
		dscan.Scan()
		if !bytes.Equal(sscan.Bytes(), dscan.Bytes()) {
			return true
		}
	}

	return false
}

func run() error {
	if len(os.Args) != 2 {
		return fmt.Errorf("USAGE: %s FILE", os.Args[0])
	}
	b, err := os.ReadFile(os.Args[1])
	if err != nil {
		return fmt.Errorf("error opening file: %v", err)
	}
	cmd := fmtCmd(b)
	cmd.Stdin = bytes.NewBuffer(bytes.Clone(b))

	// If you're formatting a source file that doesn't fit into memory,
	// you have bigger problems than keeping it formatted.
	var out bytes.Buffer
	cmd.Stdout = &out
	if err = cmd.Run(); err != nil {
		return fmt.Errorf("error running format command: %v", err)
	}

	bufore := bytes.NewBuffer(b)
	bufter := bytes.NewBuffer(bytes.Clone(out.Bytes()))
	// Formatted file is different from original, write changes
	if deepCompare(bufore, bufter) {
		if err := os.WriteFile(os.Args[1], out.Bytes(), 0644); err != nil {
			return fmt.Errorf("error writing to file: %v", err)
		}
	}

	return nil
}

func main() {
	if err := run(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
