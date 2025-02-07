@echo off
powercfg /S 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg /x -hibernate-timeout-ac 0
powercfg /x -hibernate-timeout-dc 0
powercfg /x -disk-timeout-ac 0
powercfg /x -disk-timeout-dc 0
powercfg /x -monitor-timeout-ac 10
powercfg /x -monitor-timeout-dc 10
powercfg /x -standby-timeout-ac 0
powercfg /x -standby-timeout-dc 0