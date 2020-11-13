library(dplyr)
library(ggplot2)
library(plotly)
library(plyr)

# Set up data frame
df <- read.csv("interest survey responses.csv")
df <- df %>% rename(campus_location = X)

### DEMOGRAPHICS ###

# set up sub-data frames based on class standing
freshmen <- df %>% filter(What.is.your.class.standing.for.the.2020.2021.school.year. == "Freshman")
sophomores <- df %>% filter(What.is.your.class.standing.for.the.2020.2021.school.year. == "Sophomore")
juniors <- df %>% filter(What.is.your.class.standing.for.the.2020.2021.school.year. == "Junior")
seniors <- df %>% filter(What.is.your.class.standing.for.the.2020.2021.school.year. == "Senior")
fifthYears <- df %>% filter(What.is.your.class.standing.for.the.2020.2021.school.year. == "5th-Year")
recentGrads <- df %>% filter(What.is.your.class.standing.for.the.2020.2021.school.year. == "Recent Graduate")
gradStudents <- df %>% filter(What.is.your.class.standing.for.the.2020.2021.school.year. == "Graduate Student")

# In state students based on class standing
fresh_IS <- freshmen %>% filter(I.am.an... == "In-State Student")
soph_IS <- sophomores %>% filter(I.am.an... == "In-State Student")
jun_IS <- juniors %>% filter(I.am.an... == "In-State Student")
sen_IS <- seniors %>% filter(I.am.an... == "In-State Student")
fifthY_IS <- fifthYears %>% filter(I.am.an... == "In-State Student")
recGrads_IS <- recentGrads %>% filter(I.am.an... == "In-State Student")
grads_IS <- gradStudents %>% filter(I.am.an... == "In-State Student")

# Out of state students based on class standing
fresh_OOS <- freshmen %>% filter(I.am.an... == "Out-of-State Student")
soph_OOS <- sophomores %>% filter(I.am.an... == "Out-of-State Student")
jun_OOS <- juniors %>% filter(I.am.an... == "Out-of-State Student")
sen_OOS <- seniors %>% filter(I.am.an... == "Out-of-State Student")
fifthY_OOS <- fifthYears %>% filter(I.am.an... == "Out-of-State Student")
recGrads_OOS <- recentGrads %>% filter(I.am.an... == "Out-of-State Student")
grads_OOS <- gradStudents %>% filter(I.am.an... == "Out-of-State Student")

# International students based on class standing
fresh_INT <- freshmen %>% filter(I.am.an... == "International Student")
soph_INT <- sophomores %>% filter(I.am.an... == "International Student")
jun_INT <- juniors %>% filter(I.am.an... == "International Student")
sen_INT <- seniors %>% filter(I.am.an... == "International Student")
fifthY_INT <- fifthYears %>% filter(I.am.an... == "International Student")
recGrads_INT <- recentGrads %>% filter(I.am.an... == "International Student")
grads_INT <- gradStudents %>% filter(I.am.an... == "International Student")


### DATA ANALYSIS ###

## "I had a hard time finding a group that I feel I belong to"
# Only 1 freshman surveyed, not enough data for analysis.

countStrongAgree <- juniors %>% count(
  Rate.your.level.of.agreement.with.the.following.statements...I.had.a.hard.time.finding.a.group.that.I.feel.I.belong.to.. == "Strongly Agree")

countSlightAgree <- juniors %>% count(
  Rate.your.level.of.agreement.with.the.following.statements...I.had.a.hard.time.finding.a.group.that.I.feel.I.belong.to.. == "Slightly Agree")


countDisagree <- juniors %>% count(
  Rate.your.level.of.agreement.with.the.following.statements...I.had.a.hard.time.finding.a.group.that.I.feel.I.belong.to.. != "Strongly Agree"
  || Rate.your.level.of.agreement.with.the.following.statements...I.had.a.hard.time.finding.a.group.that.I.feel.I.belong.to.. != "Slightly Agree")


fig <- plot_ly(juniors, x = ~countStrongAgree$, y = ~countSlightAgree, type = 'scatter')
ggplot(df, aes(x = c("Slightly/Strongly Agree", "Neutral and Below"),
               y = c(countStrongAgree + countSlightAgree, nrow(juniors) - (countStrongAgree + countSlightAgree)))
       + geom_bar(stat="identity", width=1))



