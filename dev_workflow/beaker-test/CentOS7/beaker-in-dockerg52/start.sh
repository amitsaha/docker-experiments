#!/bin/bash
./setup_db.sh
cd IntegrationTests
./run-tests.sh bkr.inttest.server.test_model

