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
  dplyr::summarize(count = n())%>%
  dplyr::arrange(desc(count)) %>%
 ggplot(aes(AGE, count, color=JOBROLEINTEREST))  + theme(legend.title = element_text( size = 8)) + scale_color_discrete(name="Job Role Interest")+ geom_point(alpha = 0.7, stat = "identity", position = position_jitter(width=0.5, height= 0.5))+ labs(title='Job Interest of New Coders by Age') + labs(x="Age of New Coder", y= "Count") +facet_wrap(~JOBPREF) + scale_x_discrete(breaks = c(15,25,35,45,55,65)) 



  
    

