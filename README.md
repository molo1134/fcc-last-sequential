# Get last FCC Amateur Radio sequential callsign assignments

Some shell scripts to automatically get the last sequential amateur radio
callsign assignments.

## License

2-clause BSD licensed.  See [LICENSE](LICENSE) file.

## Usage

1. Initially, download the FCC master file, extract records and place into
   local datafile, which is `$HOME/tmp/amat_hs.dat.gz` by default.  Run:

    ./getmaster.sh

2. Daily, download the FCC incremental change file, extract records and append
   onto the local datafile.  This is suitable to be used with cron.  Run:

    ./appenddaily.sh

3. Run the script to get the last sequential assignments for a callsign
   district, listed by the callsign series.  The following districts are
   allowed:

   * 1-10
   * 11/AK/KL
   * 12
   * PR/KP4
   * VI/USVI/KP2
   * 13
   * HI/KH6
   * GU/KH2
   * AS/KH8
   * MP/KH0

   Examples:

    $ ./getlastsequenial.sh 2
    D: KD2PNK
    B: KG2SC
    A: AC2WP
    
    $ ./getlastsequenial.sh 11
    D: WL7CYA
    C: KL4QC
    B: AL7RY
    A: AL6E
    
    $ ./getlastsequenial.sh PR
    D: WP4PXS
    C: WP4HA
    B: KP3CY
    A: WP3Y
    
    $ ./getlastsequenial.sh KH8
    D: WH8ABM
    C: KH8DW
    A: KH8E

## Dependencies

* awk
* date
* grep, egrep
* gzip
* mktemp
* sort
* tail
* tr
* unzip
* wget

