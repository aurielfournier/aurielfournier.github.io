---
layout: post
title: Automated Tweeting 
comments: true
---

I'm part of the team behind the [Wilson Ornithological Society twitter account](https://twitter.com/wilsonornithsoc). My main job is tweeting about the new articles in the Wilson Journal of Ornithology every time a new issue comes out (so 4 times a year). I'v been doing this since last summer, going into tweetdeck, and scheduling each tweet by hand, a process that takes several hours to do, since I want to tweet about each paper several times over the first week they are out, and make sure I hit a variety of time zones.  

I kept hearing on twitter that there are R packages that can make this easier and so this morning I took at look into them. `rtweet` is an amazing package, with great documentation! It made getting my personal account authorized to tweet really straight forward. 

The March issue of WJO isn't out quite yet, but I'm planning on using this to help spread the word about the great new papers, and not spend an entire evening scheduling tweets! 

```
library(dplyr)
library(rtweet)

## get details on twitter authorization here
## https://cran.r-project.org/web/packages/rtweet/vignettes/auth.html

appname <- "name of app"
key <- "key from twitter here"
secret <- "secret key from twitter here"

twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

df <- data.frame(tweet=c("rails are the best",
                          "no seriously, rails are great",
                          "wahooooo rails"),
                  image = c("~/../Dropbox/Photos/New folder/IMG_20170803_170808.jpg",
                  "~/../Dropbox/Photos/New folder/IMG_20171104_222533.jpg",
                  "~/../Dropbox/Photos/New folder/IMG_20171104_222526.jpg")) %>%
        mutate(tweet = as.character(tweet))

for(i in 1:nrow(df){
    post_tweet(df$tweet[i], token=twitter_token, media=df$image[i])
    # this puts a 3 minute pause between tweets, time is measured in seconds
    Sys.sleep(time=180)
}

```

Now all I need to do is figure out how to automatically pull the urls to the articles from the journal website. Though for now I might just manually pull those when I write the tweets. Happy tweeting! 
