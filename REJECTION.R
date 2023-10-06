library(googlesheets4)
library(ggplot2)
library(cowplot)
library(RColorBrewer)
#library(rgdal)
#library(maptools)
library(tidyr)
library(dplyr)
library(grid)
library(auriel)

gs4_deauth()


dat <- read_sheet("https://docs.google.com/spreadsheets/d/1HyhVgsRINRbu6vRYJJzSe7omQOK_41jtqyZmvv_iXjE/edit?usp=sharing") %>%
  filter(published_yet!="NA") 



m_by_rejects <- ggplot(data=dat, 
                       aes(x=months_between, y=rejects, 
                           group=published_yet))+
  geom_point(size=2, aes(color=published_yet, shape=published_yet))+
  ylim(0,6)+
  xlab("Months from first submission")+
  theme(legend.position="non",
        legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid'),
        axis.title.x=element_text(size=10))+
  scale_color_manual(values=c("#1f78b4","#b2df8a"),
                     name="Paper Status")+
  scale_x_continuous(breaks=c(0,12,24,36,48,60))+
  theme_fournier()

m_by_desk <- ggplot(data=dat, 
                    aes(x=months_between, y=desk_rejects, 
                        group=published_yet))+
  geom_point(size=2, aes(color=published_yet, shape=published_yet))+
  ylim(0,6)+
  xlab("Months from first submission ")+
  ylab("Desk Rejects")+
  theme(legend.position=c(0.75,0.8),
        legend.background = element_rect(colour = 'black', 
                                         fill = 'white', linetype='solid'),
        legend.title = element_text(),
        axis.title.x=element_text(size=10))+
  scale_color_manual(values=c("#1f78b4","#b2df8a"),)+
  scale_x_continuous(breaks=c(0,12,24,36,48,60))+
  guides(color=guide_legend(ncol=1, title="Paper Status"),
         shape=guide_legend(ncol=1, title="Paper Status"))+
  theme_fournier()


rejects_hist <- ggplot(data=dat,
                       
                       aes(x=rejects))+
  geom_histogram()+
  annotate("text", label=paste0("Last Updated ", Sys.Date()), 
           x=3, y=12)+
  scale_x_continuous(breaks=0:6)+
  scale_y_continuous(breaks=seq(0,14, by=2))+
  theme(axis.title.x=element_text(size=10))+
  theme_fournier()+
  ylab("Number of Papers")+
  xlab("Rejections")

desk_hist <- ggplot(data=dat,
                    aes(x=desk_rejects))+
  geom_histogram()+
  theme(axis.title.x=element_text(size=10))+
  scale_y_continuous(breaks=seq(0,21, by=3))+
  theme_fournier()+
  ylab("Number of Papers")+
  xlab("Desk rejections \n
       (rejection without review by editor)")





a <- plot_grid(m_by_rejects, m_by_desk,
               rejects_hist, desk_hist, nrow=2, align="hv")


ggsave(a, file="./images/papers.jpeg", width=20, height=15, units="cm", dpi=300)




desk<-ggplot(data=dat,
             aes(x=year_submitted_first_time, y=months_between, color=published_yet))+
  geom_jitter(size=3)+
  ylab("Months from first sub to publication")+
  theme_fournier()+
  scale_color_manual(values=c("#1f78b4","#b2df8a"),)+
  xlab("Year first submitted")+
  theme(legend.position = c(0.2,0.8))+
  guides(color=guide_legend(ncol=1, title="Paper Status"),
         shape=guide_legend(ncol=1, title="Paper Status"))+
  scale_x_continuous(breaks=c(2012,2014,2016,2018,2020,2022))




ggsave(desk, file="./images/pubtime_over_time.jpeg", width=15, height=15, units="cm", dpi=300)





# 
# 
# sumdat <- dat %>%
#   group_by(year_submitted_first_time, published_yet) %>%
#   summarize(total = sum(desk_rejects,na.rm=TRUE))
# 
# desk<-ggplot(data=sumdat,
#        aes(x=year_submitted_first_time, y=total, color=published_yet))+
#   geom_jitter(size=3)+
#   ylab("desk rejects")+
#   theme_fournier()+
#   scale_color_manual(values=c("#1f78b4","#b2df8a"),)
# 
# sumdat <- dat %>%
#   group_by(year_submitted_first_time, published_yet) %>%
#   summarize(total = sum(review_rejects,na.rm=TRUE))
# 
# review<-ggplot(data=sumdat,
#        aes(x=year_submitted_first_time, y=total, color=published_yet))+
#   geom_jitter(size=3)+
#   ylab("review rejects")+
#   theme_fournier()+
#   scale_color_manual(values=c("#1f78b4","#b2df8a"),)
# 
# sumdat <- dat %>%
#   group_by(year_submitted_first_time, published_yet) %>%
#   summarize(total = sum(rejects,na.rm=TRUE))
# 
# all<- ggplot(data=sumdat,
#        aes(x=year_submitted_first_time, y=total, color=published_yet))+
#   geom_jitter(size=3)+
#   ylab("all rejects")+
#   theme_fournier()+
#   scale_color_manual(values=c("#1f78b4","#b2df8a"),)
# 
# a <- plot_grid(desk, review, all, nrow=3, align="hv")
# 
# 
# ggsave(a, file="./images/papers_over_time.jpeg", width=15, height=30, units="cm", dpi=300)
# 



## Grants


gs4_deauth()


dat <- read_sheet("https://docs.google.com/spreadsheets/d/1MnEXtnXcgntgvLBmL_VNV1oRK0LTjvG0hmZzdUBu_vs/edit?usp=sharing")



datdat <- dat %>%
  mutate(year=factor(year)) %>%
  group_by(year, rejected_y_n) %>%
  summarize(count=n())

a <- ggplot(data=datdat, 
            aes(x=year, y=count, fill=rejected_y_n))+
  geom_bar( stat="identity", color="black",
           position = position_dodge2(width = 0.9, preserve = "single"))+
  scale_fill_manual(values=c("#1f78b4","#1b9e77","#b2df8a"),
                    name="")+
  theme_fournier()


ggsave(a, file="./images/grants.jpeg", width=20, height=15, units="cm", dpi=300)


















# 
# 
# ## JOBS
# 
# 
# dat <- gs_title("data_on_job_MSU_result")
# 
# datdat <- gs_read(dat) %>%
#         group_by(offer, interview) %>%
#         summarize(count =n())
# 
# a <- ggplot(data=datdat, 
#   aes(x=interview, y=count, fill=offer, group=offer))+
#   geom_bar(position="dodge", stat="identity")+
#   scale_fill_manual(values=c("#7570b3","#d95f02"),
#                     name="Received offer?")+
#   xlab("Was interviewed?")
# 
# 
# ggsave(a, file="./images/postdoc_jobs.jpeg", width=20, height=15, units="cm", dpi=300)
# 
# dat <- gs_title("job_search_INHS_director")
# 
# datdat <- gs_read(dat) %>%
#   mutate(interview = ifelse(is.na(date_interview),"no response",
#                       ifelse(date_interview=="N","no","yes")),
#          offer = ifelse(is.na(offer),"accepted before decision", offer)) %>%
#   group_by(interview, offer) %>%
#   summarize(count =n())
# 
# a <- ggplot(data=datdat, 
#             aes(x=interview, y=count, fill=offer, group=offer))+
#   geom_bar(position="dodge", stat="identity")+
#   scale_fill_manual(values=c("#7570b3","#d95f02","#1b9e77"),
#                     name="Received offer?")+
#   xlab("Was interviewed?")
# 
# ggsave(a, file="./images/INHS_jobs.jpeg", width=20, height=15, units="cm", dpi=300)
# 
# dat <- gs_title("job_search_INHS_director")
# 
# datdat <- gs_read(dat) %>%
#             group_by(type) %>%
#             summarize(count = n())
# 
# a <- ggplot(data=datdat, 
#             aes(x=type, y=count, fill=type))+
#   geom_bar(position="dodge", stat="identity")+
#   scale_fill_manual(values=c("#7570b3","#d95f02","#1b9e77","#e7298a"))+
#   xlab("Position Type")+
#   theme(legend.position = "none")
# 
# 
# ggsave(a, file="./images/INHS_jobs_types.jpeg", width=20, height=15, units="cm", dpi=300)
# 
# 
# dat <- gs_title("job_search_INHS_director")
# 
# 
# datdat <- gs_read(dat) %>%
#   group_by(state) %>%
#   summarize(countn = n())
# 
# ms <- usa[usa$NAME_1 %in% datdat$state,]
# 
# usa <- readRDS("~/GBNERR_wintermarshbirds/gis_data/USA_adm1.rds")
# can <- readRDS("~/GBNERR_wintermarshbirds/gis_data/CAN_adm1.rds")
# mex <- readRDS("~/GBNERR_wintermarshbirds/gis_data/MEX_adm1.rds")
# 
# us <- map_data("state") 
# us <- dplyr::filter(us, region=="michigan"|region=="wisconsin")
# 
# 
# a <- ggplot()+
#   geom_polygon(data=can,aes(x=long,y=lat,group=group), col="black", fill="white")+
#   geom_polygon(data=mex,aes(x=long,y=lat,group=group), col="black", fill="white")+
#   geom_polygon(data=usa,aes(x=long,y=lat,group=group), col="black", fill="white")+
#   coord_map("albers",lat0=25, lat1=60,xlim=c(-125,-70),ylim=c(25,57))+
#   geom_polygon(data=ms, aes(x=long,y=lat,
#                                 group=group),
#                color="black",fill="#7570b3")+
#   geom_polygon(data=us,aes(x=long,y=lat,group=group), col="black", fill=NA)
# 
# ggsave(a, file="aurielfournier.github.io/images/INHS_jobs_geography.jpeg", width=20, height=15, units="cm", dpi=300)
# 
