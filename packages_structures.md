rcarbon

## rcarbon

class: "CalDates" "list"

list of 2
- metadata
	- list of n
		- DateID    : chr
			- Name/Identifier of the 14C Date
  		- CRA       : num
			- BP Date
  		- Error     : num
			- Standard Deviation
		- Details   : logi/char
			- optional vector of meta information/free text
		- CalCurve  : chr
			- name of the calibration curve
		- ResOffsets: num
			- A vector of offset values for any marine reservoir effect
		- ResErrors : num
			- A vector of offset value errors for any marine reservoir effect
		- StartBP   : num
			- Start of the calibration curve?
		- EndBP     : num
			- End of the calibration curve?
		- Normalised: logi
			- whether or not it was normalised (Details)
		- F14C      : logi
			- A logical variable indicating whether calibration should be carried out in F14C space or not (Details)
		- CalEPS    : num
			- Cut-off value for density calculation. Default is 1e-5.
- grids
	- list of n (Data Frame)
		- calBP
			- Calender years for the calibrated result in BP
		- PrDens
			- Probabilities
### Details
Normalised: control whether the resulting calibrated distribution is normalised to 1 under-the-curve or not
F14C: Nutzung des Anteils 14C statt des BP Datums?

## Bchron

class: "BchronCalibratedDates"

list of n
- name
	- list of 5 min, 8 max
		- ages     : num
			- BP Date
		- ageSds   : num 
			- Standard Deviation
		- calCurves: chr
			- Name of the calibration curve
		- ageGrid  : num
			- Calender years for the calibrated result in BP (vector)
		- densities: num
			- A vector of probability values indicating the probability value for each element in ageGrid

optional:			
		- positions
			- The position of the age (usually the depth)
		- ageLab
			- The label given to the age variable
		- positionLab
			- The label given to the position variable
## OxcAAR

class: "list" "oxcAARCalibratedDatesList"

list of n
	- oxcAARCalibratedDate

class: "oxcAARCalibratedDate"

list of 9
- name                   : chr
	- name/id of the date
- type                   : chr
	- type of oxcal date (Details)
- bp                     : int
	- BP Value
- std                    : int
	- Standard deviation
- cal_curve              :List of 5
	- name
		- name of the calibration curve
	- resolution: num
		- resolution of the calibration curve
	- bp        : num
		- BP Values of the calibration curve
  	- bc        : num
		- BC Values of the calibration curve
  	- sigma     : num
		- standard deviations of the calibration curve
- sigma_ranges           :List of 3
  - one_sigma  :'data.frame'
	  - start      : num
		- vector of beginnings of sigma ranges
	  - end        : num
	  	- vector of ends of sigma ranges
	  - probability: num
	  	- vector of probilities for that sigma range
  - two_sigma  :'data.frame'
  	- as one sigma
  - three_sigma:'data.frame'
  	- as one sigma
- raw_probabilities      :'data.frame'
	- dates        : num
		- vector of BC dates for probabilities
	- probabilities: num
		- vector of BC dates for probabilities
- posterior_sigma_ranges :List of 3
	- as sigma ranges for modeled (bayesian) results
- posterior_probabilities
	- as raw_probabilities for modeled (bayesian) results
### Details
type: result type comming from oxcal:
	- R_Date, C_Date, Sum ...

## Bacon
result stored in file system

... rather complicated structure, maybe for next version? ...

## clam

result stored in file system

... also rather complicated structure, full translation also maybe for next version? ...

clam::calibrate(5000, 50)

list of 2
- calib : matrix[,2]
	- [,1] BP
	- [,2] probabilities
- hdp: matrix[,3]
	- yrmin
		- begin sigma range
	- yrmax
		- end sigma range
	- prob
		- probability sigma range

### details
sigma range value is given as input, but not stores in result

## c14bazaar

### Note
primary a package collecting 14C data from databases, so primarily intended for uncalibrated data. But calibration function included using bchron

test <- get_c14data("jomon")
c14bazAAR_str <- calibrate (test[1:2,])

class: "c14_date_list" "tbl_df" "tbl" "data.frame"   

tibble [n × 14]

- sourcedb        : chr
	- name of the source data base
- sourcedb_version: Date
	- date of data access
- labnr           : chr
	- name/identifier of the 14C date
- c14age          : int
	- BP
- c14std          : int
	- Standard deviation
- calrange        :List of x (Details)
  - 'data.frame':	2 obs. of  3 variables:
	  - dens: num
		  - probability sigma range
	  - from: num
		  - begin sigma range
	  - to  : num
		  - end sigma range
- sigma           : num
	- value of sigma range (1,2,3)
- c13val          : num
	- value of delta13C
- site            : chr
	- Name of the site
- sitetype        : chr
	- type of site
- period          : chr
	- period of site
- material        : chr
	- sample material
- region          : chr
	- self explanatory
- shortref        : chr
	- literature reference
 
 ### Details

## ArcheoPhases
Tools for the post-processing of the Markov Chain simulated by any software used for the construction of archeological chronologies

no interface meaningful?


## archSeries
Tools for Chronological Uncertainty in Archaeology
no interface meaningful?