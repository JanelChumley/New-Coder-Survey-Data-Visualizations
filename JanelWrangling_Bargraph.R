require("jsonlite")
require("RCurl")
require("dplyr")
require("tidyr")
require("ggplot2")
require("ggthemes") 

df <- data.frame(fromJSON(getURL(URLencode('oraclerest.cs.utexas.edu:5001/rest/native/?query="select * from newcoder"'),httpheader=c(DB='jdbc:oracle:thin:@aevum.cs.utexas.edu:1521/f16pdb', USER='cs329e_cb38335', PASS='orcl_cb38335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

df %>% 
  dplyr::select(AGE,JOBROLEINTEREST, JOBPREF) %>% 
  dplyr::filter(AGE!="null", JOBROLEINTEREST != "null", JOBPREF != "null")%>% 
  dplyr::group_by(AGE, JOBROLEINTEREST, JOBPREF) %>% 
  dplyr::summarize(count = n())%>%dplyr::arrange(desc(count))%>%
  ggplot(aes(AGE, count, fill=JOBROLEINTEREST))  + geom_bar(stat = "identity", position = "stack")  + labs(title='Job Interest of New Coders by Age') +labs(x="Age of New Coder", y= "Number of New Coders") +  scale_x_discrete(breaks = c(15,20,25,30,35,40,45,50,55,60,65)) + theme(plot.title = element_text(size=10), legend.title = element_text(size=8, face="bold")) + scale_fill_discrete(name="Job Role Interests")



  
    

