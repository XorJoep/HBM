`define    tDQSCK        1.50
`define    tDQSCK_AERR   1.92
`define    tDQSCK_DERR   1.65
`define    tOVWSO        2.29
`define    TEMPERATURE     86                    //IEEE1500
`define    _NUM_RCA      6
`define    _NUM_CCA      8
`define    _NUM_DQ       128
`define    _NUM_DS       4
`define    _NUM_DBI      16
`define    _NUM_DM       16
`define    _NUM_PAR      4
`define    nActual_size  1048576                 // Memory Allocation size : USER Defined value!!!

//-------------------------------------------------//
// -- AC parameters                                //
//-------------------------------------------------//
`ifdef S2000
	`define     tRASmin         (3*tcc_p, 33)        // max(N*nCK, value[ns])
	`define     tRAS            (3*tcc_p, 33)        // max(N*nCK, value[ns])
	`define     tRCDRD          (3*tcc_p, 14)        // max(N*nCK, value[ns])
	`define     tRCDWR          (3*tcc_p, 10)        // max(N*nCK, value[ns])
	`define     tRRDL           (2*tcc_p, 4)         // max(N*nCK, value[ns])
	`define     tRRDS           (2*tcc_p, 4)         // max(N*nCK, value[ns])
	`define     tFAW            (8*tcc_p, 16)        // max(N*nCK, value[ns])
	`define     tRP             (3*tcc_p, 14)        // max(N*nCK, value[ns])
	`define     tXP             (4*tcc_p, 7.5)       // max(N*nCK, value[ns])
	`define     tXS             (5*tcc_p, `tRFC+10)  // max(N*nCK, value[ns])
	`define     tRFCSB          160                  // ns
	`define     tRREFD          (2*tcc_p, 8)         // max(N*nCK, value[ns])
	`define     tMOD            (12*tcc_p, 15)       // max(N*nCK, value[ns])
	`define     tCKmin          1                    // ns 
`elsif S1600
	`define     tRASmin         (3*tcc_p, 33)        // max(N*nCK, value[ns])
	`define     tRAS            (3*tcc_p, 33)        // max(N*nCK, value[ns])
	`define     tRCDRD          (3*tcc_p, 14)        // max(N*nCK, value[ns])
	`define     tRCDWR          (3*tcc_p, 10)        // max(N*nCK, value[ns])
	`define     tRRDL           (2*tcc_p, 4)         // max(N*nCK, value[ns])
	`define     tRRDS           (2*tcc_p, 4)         // max(N*nCK, value[ns])
	`define     tFAW            (8*tcc_p, 16)        // max(N*nCK, value[ns])
	`define     tRP             (3*tcc_p, 14)        // max(N*nCK, value[ns])
	`define     tXP             (4*tcc_p, 7.5)       // max(N*nCK, value[ns])
	`define     tXS             (5*tcc_p, `tRFC+10)  // max(N*nCK, value[ns])
	`define     tRFCSB          160                  // ns
	`define     tRREFD          (2*tcc_p, 8)         // max(N*nCK, value[ns])
	`define     tMOD            (12*tcc_p, 15)       // max(N*nCK, value[ns])
	`define     tCKmin          1.25                 // ns 
`elsif S1000
	`define     tRASmin         (3*tcc_p, 33)        // max(N*nCK, value[ns])
	`define     tRAS            (3*tcc_p, 33)        // max(N*nCK, value[ns])
	`define     tRCDRD          (3*tcc_p, 14)        // max(N*nCK, value[ns])
	`define     tRCDWR          (3*tcc_p, 10)        // max(N*nCK, value[ns])
	`define     tRRDL           (2*tcc_p, 4)         // max(N*nCK, value[ns])
	`define     tRRDS           (2*tcc_p, 4)         // max(N*nCK, value[ns])
	`define     tFAW            (8*tcc_p, 16)        // max(N*nCK, value[ns])
	`define     tRP             (3*tcc_p, 14)        // max(N*nCK, value[ns])
	`define     tXP             (4*tcc_p, 7.5)       // max(N*nCK, value[ns])
	`define     tXS             (5*tcc_p, `tRFC+10)  // max(N*nCK, value[ns])
	`define     tRFCSB          160                  // ns
	`define     tRREFD          (2*tcc_p, 8)         // max(N*nCK, value[ns])
	`define     tMOD            (12*tcc_p, 15)       // max(N*nCK, value[ns])
	`define     tCKmin          2                    // ns 
`else
	`define     tRASmin         (3*tcc_p, 33)        // max(N*nCK, value[ns])
	`define     tRAS            (3*tcc_p, 33)        // max(N*nCK, value[ns])
	`define     tRCDRD          (3*tcc_p, 14)        // max(N*nCK, value[ns])
	`define     tRCDWR          (3*tcc_p, 10)        // max(N*nCK, value[ns])
	`define     tRRDL           (2*tcc_p, 4)         // max(N*nCK, value[ns])
	`define     tRRDS           (2*tcc_p, 4)         // max(N*nCK, value[ns])
	`define     tFAW            (8*tcc_p, 16)        // max(N*nCK, value[ns])
	`define     tRP             (3*tcc_p, 14)        // max(N*nCK, value[ns])
	`define     tXP             (4*tcc_p, 7.5)       // max(N*nCK, value[ns])
	`define     tXS             (5*tcc_p, `tRFC+10)  // max(N*nCK, value[ns])
	`define     tRFCSB          160                  // ns
	`define     tRREFD          (2*tcc_p, 8)         // max(N*nCK, value[ns])
	`define     tMOD            (12*tcc_p, 15)       // max(N*nCK, value[ns])
	`define     tCKmin          1                    // ns 
`endif

`define     tMRD            8                    // nCK
`define     tCPDED          2                    // nCK
`define     tWTRL           (4*tcc_p, 7.5)       // max(N*nCK, value[ns])
`define     tWTRS           (2*tcc_p, 2.5)       // max(N*nCK, value[ns])
`define     tACTPDE         1                    // nCK
`define     tPRPDE          1                    // nCK
`define     tREFPDE         1                    // nCK
`define     tREFSBPDE       1                    // nCK
`define     tMRSPDE         (12*tcc_p, 15)       // max(N*nCK, value[ns])
`define     nCKE            10                   // nCK    
`define     nCKESR          100                  // nCK        
`define     tWR             (3*tcc_p, 15)        // max(N*nCK, value[ns])
`define     tCKmax          20                   // ns 
`define     tCLmin          0.47                 // nCK
`define     tCLmax          0.53                 // nCK
`define     tCHmin          0.47                 // nCK
`define     tCHmax          0.53                 // nCK
`define     tCKES           0.125                // ns
`define     tCKEH           0.125                // ns
`define     tIS             0.125                // ns
`define     tIH             0.125                // ns
`define     tIPW            0.400                // ns
`define     tDS             0.125                // ns
`define     tDH_SEC         0.125                // ns
`define     tINIT0          10000                // ns
`define     tINIT1          200000               // ns
`define     tINIT2          10                   // ns
`define     tINIT3          500000               // ns
`define     tINIT4          10                   // nCK
`define     tINIT5          200                  // ns
`define     tPW_RESET       1000                 // ns

`define     tSR             5                    // WSP input setup time to WRCK rising edge
`define     tHR             5                    // WSP input hold time form WRCK rising edge
`define     tSF             5                    // WSP input setup time to WRCK falling edge
`define     tHF             5                    // WSP input hold time from WRCK falling edge

//---------------------------------------//
// -- User Defined value for fast sim -- //
//---------------------------------------//
//HARD_REPAIR, HARD_LANE_REPAIR time must be greater than 1us
`define    tSREP   300                           // SOFT_REPAIR minimum waiting time (unit: nWRCK)
`define    tHREP   100000000                     // HARD_REPAIR minimum waiting time (unit: ns)
`define    tSLREP  10                            // SOFT_LANE_REPAIR minimum waiting time (unit: nWRCK)
`define    tHLREP  10000000                      // HARD_LANE_REPAIR minimum waiting time (unit: ns)
`define    tUPDMRS 250                           // WDR update to Mode Register valid delay (unit: nWRCK)
//MBIST time must be greater than 100us
`define    tMBIST  5000000000                    // MBIST time (unit: ns)
//TEMPERATURE sensor valid time
`define    tTEMP   500000                        // (unit: ns)
