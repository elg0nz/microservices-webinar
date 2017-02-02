package main

import (
	"fmt"
	"github.com/jrallison/go-workers"
)

func GoWorker(message *workers.Msg) {
	fmt.Println(message)
}

func main() {
	workers.Configure(map[string]string{
		// location of redis instance
		"server": "localhost:6379",
		// instance of the database
		"database": "1",
		// number of connections to keep open with redis
		"pool": "10",
		// unique process id for this instance of workers (for proper recovery of inprogress jobs on crash)
		"process": "1",
	})

	// pull messages from "go_queue" with concurrency of 10
	workers.Process("go_queue", GoWorker, 10)

	// Blocks until process is told to exit via unix signal
	workers.Run()
}
