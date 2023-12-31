# ILI-reliability-wrapper
perform split-halves analysis of ILI computations from resting state data

This wrapper generates submission scripts for each MSC subject to:
(1) run crossotope.sif on a specified bin of resting state data sampled from the first half of a subject's dtseries (defined by max_minutes key value in config.json) to generate L&R values for 7 specified ROIs
(2) run crossotope.sif on the resulting ROI L&R values to compute ILI per ROI
(3) Computes Pearson correlation between the 7 ROI ILI values (from step 2) and ground truth ROI ILI computed prior for the full 2nd half of the subject's dtseries

The resulting correlation coefficients are saved to a csv file. Currently there is one csv file output per subject and per time bin, each of which will contain a list of 1000 correlation coefficients once the process is complete for the specified time bin of a subject