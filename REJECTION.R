library(googlesheets)
library(ggplot2)
library(tidyverse)
library(cowplot)
library(RColorBrewer)

dat <- gs_title("data_on_my_papers")

datdat <- gs_read(dat) %>%
  mutate(published_yet = ifelse(is.na(month_accepted),"no","yes"))

m_by_rejects <- ggplot(data=datdat, 
       aes(x=months_betwee, y=rejects, color=published_yet))+
  geom_point()+
  ylim(0,6)+
  xlab("Months from first submission 
       \n to acceptance")+
  theme(legend.position=c(0.6,0.8),
        legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid'))+
  scale_color_manual(values=c("#7570b3","#d95f02"))

m_by_desk <- ggplot(data=datdat, 
       aes(x=months_betwee, y=desk_rejects, color=published_yet))+
  geom_point()+
  ylim(0,6)+
  xlab("Months from first submission 
       \n to acceptance")+
  theme(legend.position=c(0.6,0.8),
        legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid'))+
  scale_color_manual(values=c("#7570b3","#d95f02"))

rejects_hist <- ggplot(data=datdat,
       aes(x=rejects))+
  geom_histogram()

desk_hist <- ggplot(data=datdat,
       aes(x=desk_rejects))+
  geom_histogram()


a <- plot_grid(m_by_rejects, m_by_desk,
          rejects_hist, desk_hist, nrow=2)


ggsave(a, file="aurielfournier.github.io/images/papers.jpeg", width=20, height=15, units="cm", dpi=300)


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


ggsave(a, file="aurielfournier.github.io/images/jobs.jpeg", width=20, height=15, units="cm", dpi=300)


## Grants

dat <- gs_title("data_on_grants")

datdat <- gs_read(dat) %>%
  mutate(year=factor(year)) %>%
  group_by(year, rejected_y_n) %>%
  summarize(count=n())

a <- ggplot(data=datdat, 
            aes(x=year, y=count, fill=rejected_y_n))+
  geom_bar(position="dodge", stat="identity", color="black")+
  scale_fill_manual(values=c("#7570b3","#1b9e77","#d95f02"),
                    name="Rejected?")


ggsave(a, file="aurielfournier.github.io/images/grants.jpeg", width=20, height=15, units="cm", dpi=300)
