# Red List Downloader

Script to download basic info from the IUCN Red List including taxonomy, rating and criteria, assessor etc. 
Written by Steve Bachman & Justin Moat

```
# Query Red List API and assessments using 'rredlist' package
#
# https://cran.r-project.org/web/packages/rredlist/index.html
#
# Note that there may be a rate limiting issue when sending calls to the API. Either try running the script several
# times or add a delay between calls

#if rredlist package already installed - load package, if not:
install.packages("rredlist")
library(rredlist)

#RL key - ***change this to your own key. Generate a token here: http://apiv3.iucnredlist.org/api/v3/token
rlkey <- "my key"

# get the species IDs by looping through pages (10,000 each) until no more results
i=1
testcount = 1
rl = rl_sp(0, key = rlkey)
rl.all = rl$result

  while ((testcount)>'0'){
  test = rl_sp(i, key = rlkey)
  testcount = test$count
  rl.all = rbind(rl.all,test$result)
  i = i+1
    }

# filter on plants 'PLANTAE'
plants <- rl.all[ which(rl.all$kingdom_name=='PLANTAE'),] 

# filter out the first column 'taxon ID'
plants.id = plants[,1]
str(plants.id)

# function to get the species info based on each ID
rl.apply = function(x){
  sp <- rl_search(id=x,key=rlkey)
  sp = sp$result
  return(sp)
  }

#run lapply on rl.apply function
t = proc.time()
apply.rl = lapply(plants.id,rl.apply)
rl_df = as.data.frame(do.call(rbind,apply.rl))
proc.time()- t

#get version number
version = rl_version(key = rlkey)

#get date
today = Sys.Date()

#file path - set your own path
respath = paste0("C:/dump/PLANTAE_version_",version,"_run_on_",today,".csv")

# change the directory where you want to save the data -
write.table(rl_df, respath,row.names = FALSE, na="", sep = ",")

# A similar script can be used to get more detailed info on threats, conservation measures, growth forms, narratives, countries, habitats etc. using the rredlist package
```
