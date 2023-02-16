# Complete Workflow

### **Step 0: Re-initialize the networked population with the new synthetic population data in R.**

#### 💡 Environment setup and ERGM fitting details are explained at project [README](https://bitbucket.org/jozik/hepcep_networks/src/master/README.md)

- Networked population with demographic data is initialized in [generate-starting-network-meta-data.R](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/generate-starting-network-meta-data.R).
- The previous set of demographic data that were used to initialize agents in 32 groups were derived from the old synthpop data as described in [demog_prop.xlsx](https://bitbucket.org/jozik/hepcep_networks/src/master/data/demog_prop_est.xlsx). The proportions in this dataset were computed by Mary Ellen directly.
- The initial network data RData (“meta-mixing-init-net.RData”), used for the publication and from which I described results in our last meeting was generated in a previous commit (4f353c6) of the [generate-starting-network-meta-data.R](https://bitbucket.org/jozik/hepcep_networks/src/4f353c6a66f8791e9ab87aebb1395021b8e75c0d/fit-ergms/generate-starting-network-meta-data.R?at=master) file.
- Therefore, the demographic group proportion data needed to be updated in this round and the “meta-mixing-init-net.RData” file needed to be regenerated.
- These steps are completed, as described below, along with a few of the other next steps.

### **Step I: Compute the new demographic proportions (i.e., 32 groups as seen above), using the [new demographic data](https://bitbucket.org/jozik/hepcep_networks/src/master/data/synthpop-2022-06-27%2013_29_03.csv) that Arindam provided.**

- Code to compute the new proportions with Arindam’s synthpop data is at [compute-demographic-proportions.R](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/compute-demographic-proportions.R).
- The proportions dataset computed using the new synthpop data is at [demog_dt_props.csv](https://bitbucket.org/jozik/hepcep_networks/src/master/data/demog_dt_props.csv).

### **Step II: Regenerate the starting network using these updated proportions.**

- Done in [generate-starting-network-meta-data.R](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/generate-starting-network-meta-data.R) (commit 6af5b48).
- I have checked that the proportions in the new population match our expectation: See (or run) [test-network-initialization.R](https://bitbucket.org/jozik/hepcep_networks/src/master/test-network-initialization.R).

### **Step III: Refit the ERGMs**

- Pulled the repository on Midway.
- Reran the [generate-starting-network-meta-data.R](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/generate-starting-network-meta-data.R) to produce local meta mixing RData:
- rw-rw-r-- 1 khanna7 pi-ahotton 369080 Aug 2 14:31 meta-mixing-init-net.RData
- Checked the ERGM fit code for any needed updates: [ergm-estimation-with-meta-data.R](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/ergm-estimation-with-meta-data.R)
- Updated filepaths in line [19](https://bitbucket.org/jozik/hepcep_networks/src/686cd035dcf1b0176919dda457cc07b7becea59a/fit-ergms/ergm-estimation-with-meta-data.R#lines-19) and filename in line [30](https://bitbucket.org/jozik/hepcep_networks/src/686cd035dcf1b0176919dda457cc07b7becea59a/fit-ergms/ergm-estimation-with-meta-data.R#lines-30).
- Submitted job on a login node.
- Job got stuck (August 3, 14:06).
- Resubmitted job, this time through a [submission script](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/ergm-estimation-with-meta-mixing-data.sh) on August 4, about 9:30 AM ET.
- Step length converged once, but the [job timed out](https://bitbucket.org/jozik/hepcep_networks/commits/2fe7ae1c66af40ca2495e0a9a9ab4b435d67e51f) (see commit 2fe7ae1).
- Submitted the fitting job again on August 6 at about 10:50 AM ET (Job ID 21919683). Requested RCC to increase the wall-time to 50 hours.
- Fit converged; see [new-synthpop-data-fit](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/out/new-synthpop-data-fit). (Note that it took the same number of iterations to converge once as last time). Run time 1-13:35:43, COMPLETED, ExitCode 0.

### **Step IV: Check to see if the ERGM converges**

- MCMC diagnostics completed at [mcmc-diagnostics.R](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/tests/mcmc-diagnostics.R).
- Results at [new-synthpop.pdf](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/tests/out/new-synthpop.pdf) (I cannot view them in the web browser, but I can download the content and open it locally).

### **Step V: Simulate 100 networks from the fit**

- See commit [48d4bcb](https://bitbucket.org/jozik/hepcep_networks/src/48d4bcb0ebb39b44fbde09586f643493a73fbe10/simulate-from-ergms/simulate-networks-from-meta-data-ergm-fit.R?at=master) of [simulate-networks-from-meta-data-ergm-fit.R](https://bitbucket.org/jozik/hepcep_networks/src/master/simulate-from-ergms/simulate-networks-from-meta-data-ergm-fit.R)
- Comparison of mean statistics across 100 networks with targets: [new-synthpop-100-netws.Rout](https://bitbucket.org/jozik/hepcep_networks/src/master/simulate-from-ergms/out/new-synthpop-100-netws.Rout).

Code to compute 2.5th and 97.5th percentiles:

[summaries-across-simulated-distributions.R](https://bitbucket.org/jozik/hepcep_networks/src/master/simulate-from-ergms/summaries-across-simulated-distributions.R)

. R session output:

[new-synthpop-compute-summaries.Rout](https://bitbucket.org/jozik/hepcep_networks/src/master/simulate-from-ergms/out/new-synthpop-compute-summaries.Rout)

