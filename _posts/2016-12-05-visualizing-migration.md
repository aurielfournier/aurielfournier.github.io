---
layout: post
title: Visualizing Migration: Synthesizing Different Datasets
---

One of the challenges of working with rails is we know so little about them, and what we do know is often scattered in small data points here from the 1960s, and here from the 2000s. There is little data that has been collected in a deliberate way over a long period. As a result I often end up digging into some literature to find data. 

The first place I looked was The Birds of North America, which provides detailed species accounts for each species. These graphs showed me some data, with literal question marks on it, that didn't provide a lot of guidance as to when Virginia Rails were migrating

![](figures/25019091.gif)

Over the past two years I've tracked down almost all the issues of The Bluebird, journal of the Audubon Society of Missouri, and compiled all the spring and autumn migration data contained therein [Data available here on figshare](https://figshare.com/articles/The_Bluebird_Rail_Data/2760913). These data are oppurtunistic at best (someone saw a rail, and decided to report it) but when looking at pre-eBird times (eBird being a very large online database of citizen science bird obsevations, which really took over after 2000) these kind of state by state resources can be vital. 

I targeted Missouri because that is where my own field work takes place and I was seeking data to compare to my own. In five years and over 1000 hours of surveys I hadn't seen very many Yellow or Virginia Rails (<100 in each case). This made quantifying their migration difficult especially because I am assuming some level of year to year variability in migration, which is common among birds. 

So I sought out this other data, from the state Audubon Society. I also downloaded all August-November eBird.org observations for Missouri, Illinois, Indiana, Kentucky and Ohio (roughly the same latitude as Missouri and within the same [adminsitrative flyway](https://www.fws.gov/birds/management/flyways.php)). These represent another type of oppurtunistic data, where members of the public go out birding, record what they see, and submit their observations. More data points were available here but eBird data can be biased because people tend to bird where they live, meaning effort is not evenly distributed across the landscape. So I sought out a third type of data, building strikes. 

When I tell people rails hit buildings they are often surprised, but many many bird species have been recorded striking buildings. Many species of birds migrate at night and the lights on tall structures in large cities (and even in less urban situations) can disorient them and lead to collisions. In many large cities there are building strike monitoring programs where people walk the same route each morning and record what is found on the sidewalk (in many cases the dead birds are also collected and given to a museum, YAH MUSEUMS!). These data could be another interesting source since they are being collected each day in the same place, though this is only occuring in large cities. I obtained these data points from Loss et al (2014), Thanks Scott!

So I have these three kinds of data, and my own data, and I want to figure out what on earth they can tell me about the migration of two of the least studied birds in North America.

I thought about doing this a few different ways, first trying histograms, and line graphs, even scatter plots. None of these seemed to work. All the sample sizes were different and whatever the story was it was lost. 


Then I tried box plots, with the idea this would help take out the highly variable y axis due to different sample sizes, and allow us to compare the duration and median date of migration. 

![images/figure2.jpeg]

This was ok. I only had one data point for building strikes of Yellow Rails, so I excluded it, and this figure is fine. But I wasn't really happy with it, 


## Citations 


Conway, Courtney J.. (1995). Virginia Rail (Rallus limicola), The Birds of North America (P. G. Rodewald, Ed.). Ithaca: Cornell Lab of Ornithology; Retrieved from the Birds of North America: https://birdsna.org/Species-Account/bna/species/virrai
DOI: 10.2173/bna.173

Loss, S. R. S. S., T. Will, P. P. Marra, S. R. S. S. Loss, and P. P. Marra. 2014. Bird–building collisions in the United States: Estimates of annual mortality and species vulnerability. Condor 116:8–23. <http://www.bioone.org/doi/abs/10.1650/CONDOR-13-090.1%5Cnhttp://dx.doi.org/10.1650/CONDOR-13-090.1>.

