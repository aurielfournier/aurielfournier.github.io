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
