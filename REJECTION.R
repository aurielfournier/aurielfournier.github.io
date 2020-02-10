library(googlesheets)
library(ggplot2)
library(cowplot)
library(RColorBrewer)
library(rgdal)
library(maptools)
library(tidyr)
library(dplyr)
library(grid)
library(auriel)

dat <- gs_title("data_on_my_papers")

datdat <- gs_read(dat) %>%
  mutate(published_yet = ifelse(is.na(month_accepted),"In Review","Published"))

m_by_rejects <- ggplot(data=datdat, 
       aes(x=months_betwee, y=rejects, 
           group=published_yet))+
  geom_point(size=2, aes(color=published_yet, shape=published_yet))+
  ylim(0,6)+
  xlab("Months from first submission 
       \n to acceptance")+
  theme(legend.position="non",
        legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid'))+
  scale_color_manual(values=c("#1f78b4","#b2df8a"),
                     name="Paper Status")+
  scale_x_continuous(breaks=c(0,12,24,36))+
    theme_fournier()

m_by_desk <- ggplot(data=datdat, 
       aes(x=months_betwee, y=desk_rejects, 
           group=published_yet))+
  geom_point(size=2, aes(color=published_yet, shape=published_yet))+
  ylim(0,6)+
  xlab("Months from first submission 
       \n to acceptance")+
  ylab("Desk Rejects")+
  theme(legend.position=c(0.7,0.8),
        legend.background = element_rect(colour = 'black', 
                                  fill = 'white', linetype='solid'),
        legend.title = element_text())+
  scale_color_manual(values=c("#1f78b4","#b2df8a"),)+
  scale_x_continuous(breaks=c(0,12,24,36))+
  guides(color=guide_legend(ncol=1, title="Paper Status"),
         shape=guide_legend(ncol=1, title="Paper Status"))+
  theme_fournier()
  

rejects_hist <- ggplot(data=datdat,
                       
       aes(x=rejects))+
  geom_histogram()+
  annotate("text", label=paste0("Last Updated ", Sys.Date()), 
           x=3, y=8)+
  scale_x_continuous(breaks=0:6)+
  theme_fournier()
  
desk_hist <- ggplot(data=datdat,
       aes(x=desk_rejects))+
  geom_histogram()+
  theme_fournier()


a <- plot_grid(m_by_rejects, m_by_desk,
          rejects_hist, desk_hist, nrow=2, align="hv")


ggsave(a, file="./images/papers.jpeg", width=20, height=15, units="cm", dpi=300)



## Grants

dat <- gs_title("data_on_grants")

datdat <- gs_read(dat) %>%
  mutate(year=factor(year)) %>%
  group_by(year, rejected_y_n) %>%
  summarize(count=n())

a <- ggplot(data=datdat, 
            aes(x=year, y=count, fill=rejected_y_n))+
  geom_bar( stat="identity", color="black",
           position = position_dodge2(width = 0.9, preserve = "single"))+
  scale_fill_manual(values=c("#1f78b4","#1b9e77","#b2df8a"),
                    name="Rejected?")


ggsave(a, file="./images/grants.jpeg", width=20, height=15, units="cm", dpi=300)




















## JOBS


dat <- gs_title("data_on_job_MSU_result")

datdat <- gs_read(dat) %>%
        group_by(offer, interview) %>%
        summarize(count =n())

a <- ggplot(data=datdat, 
  aes(x=interview, y=count, fill=offer, group=offer))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values=c("#7570b3","#d95f02"),
                    name="Received offer?")+
  xlab("Was interviewed?")


ggsave(a, file="./images/postdoc_jobs.jpeg", width=20, height=15, units="cm", dpi=300)

dat <- gs_title("job_search_INHS_director")

datdat <- gs_read(dat) %>%
  mutate(interview = ifelse(is.na(date_interview),"no response",
                      ifelse(date_interview=="N","no","yes")),
         offer = ifelse(is.na(offer),"accepted before decision", offer)) %>%
  group_by(interview, offer) %>%
  summarize(count =n())

a <- ggplot(data=datdat, 
            aes(x=interview, y=count, fill=offer, group=offer))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values=c("#7570b3","#d95f02","#1b9e77"),
                    name="Received offer?")+
  xlab("Was interviewed?")

ggsave(a, file="./images/INHS_jobs.jpeg", width=20, height=15, units="cm", dpi=300)

dat <- gs_title("job_search_INHS_director")

datdat <- gs_read(dat) %>%
            group_by(type) %>%
            summarize(count = n())

a <- ggplot(data=datdat, 
            aes(x=type, y=count, fill=type))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values=c("#7570b3","#d95f02","#1b9e77","#e7298a"))+
  xlab("Position Type")+
  theme(legend.position = "none")


ggsave(a, file="./images/INHS_jobs_types.jpeg", width=20, height=15, units="cm", dpi=300)


dat <- gs_title("job_search_INHS_director")


datdat <- gs_read(dat) %>%
  group_by(state) %>%
  summarize(countn = n())

ms <- usa[usa$NAME_1 %in% datdat$state,]

usa <- readRDS("~/GBNERR_wintermarshbirds/gis_data/USA_adm1.rds")
can <- readRDS("~/GBNERR_wintermarshbirds/gis_data/CAN_adm1.rds")
mex <- readRDS("~/GBNERR_wintermarshbirds/gis_data/MEX_adm1.rds")

us <- map_data("state") 
us <- dplyr::filter(us, region=="michigan"|region=="wisconsin")


a <- ggplot()+
  geom_polygon(data=can,aes(x=long,y=lat,group=group), col="black", fill="white")+
  geom_polygon(data=mex,aes(x=long,y=lat,group=group), col="black", fill="white")+
  geom_polygon(data=usa,aes(x=long,y=lat,group=group), col="black", fill="white")+
  coord_map("albers",lat0=25, lat1=60,xlim=c(-125,-70),ylim=c(25,57))+
  geom_polygon(data=ms, aes(x=long,y=lat,
                                group=group),
               color="black",fill="#7570b3")+
  geom_polygon(data=us,aes(x=long,y=lat,group=group), col="black", fill=NA)

ggsave(a, file="aurielfournier.github.io/images/INHS_jobs_geography.jpeg", width=20, height=15, units="cm", dpi=300)

