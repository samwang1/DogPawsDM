library(dplyr)
library(ggplot2)
library(plotly)
library(plyr)

# Set up data frame
df <- read.csv("interest survey responses.csv")
df <- df %>% rename(campus_location = X)

## TRANSFORM LIKERT SCALE TO NUMERIC SCALE:
## Strongly Agree = 7, Agree = 6, Slightly Agree = 5, Neither Agree/Disagree = 4,
##  Slightly Disagree = 3, Disagree = 2, Strongly Disagree = 1

# Do for all questions that need analysis
sel_dont_belong <- df %>% 
  select(Rate.your.level.of.agreement.with.the.following.statements...I.had.a.hard.time.finding.a.group.that.I.feel.I.belong.to..)

# Change Likert to Numeric scale
sel_dont_belong <- revalue(unlist(sel_dont_belong), c("Strongly Agree" = "7", "Agree" = "6", "Slightly Agree" = "5", "Neither Agree/Disagree" = "4",
                                                                    "Slightly Disagree" = "3", "Disagree" = "2", "Strongly Disagree" = "1"))
# Mutate data-frame
df <- df %>%
  mutate(dont_belong_numeric = sel_dont_belong)

### "I find it hard to make friends at UW"
sel_hard_make_friends <- df %>% 
  select(Rate.your.level.of.agreement.with.the.following.statements...I.find.it.hard.to.make.friends.at.UW..)
sel_hard_make_friends <- revalue(unlist(sel_hard_make_friends), c("Strongly Agree" = "7", "Agree" = "6", "Slightly Agree" = "5", "Neither Agree/Disagree" = "4",
                                                            "Slightly Disagree" = "3", "Disagree" = "2", "Strongly Disagree" = "1"))
df <- df %>%
  mutate(hard_make_friends_numeric = sel_hard_make_friends)

### "I initially felt lost when I came to UW"
sel_feel_lost <- df %>% 
  select(Rate.your.level.of.agreement.with.the.following.statements...I.initially.felt.lost.coming.when.I.came.to.UW..)
sel_feel_lost <- revalue(unlist(sel_feel_lost), c("Strongly Agree" = "7", "Agree" = "6", "Slightly Agree" = "5", "Neither Agree/Disagree" = "4",
                                                          "Slightly Disagree" = "3", "Disagree" = "2", "Strongly Disagree" = "1"))
df <- df %>% 
  mutate(feel_lost_numeric = sel_feel_lost)

### "I find it easy to form study groups"
sel_easy_study_grp <- df %>% 
  select(Rate.your.level.of.agreement.with.the.following.statements...I.find.it.easy.to.form.study.groups..)
sel_easy_study_grp <- revalue(unlist(sel_easy_study_grp), c("Strongly Agree" = "7", "Agree" = "6", "Slightly Agree" = "5", "Neither Agree/Disagree" = "4",
                                                               "Slightly Disagree" = "3", "Disagree" = "2", "Strongly Disagree" = "1"))
df <- df %>% 
  mutate(easy_study_grp_numeric = sel_easy_study_grp)

### "I have a lot of friends from class or study groups"
sel_friends_from_class <- df %>% 
  select(Rate.your.level.of.agreement.with.the.following.statements...I.have.a.lot.of.friends.from.class.or.study.groups..)
sel_friends_from_class <- revalue(unlist(sel_friends_from_class), c("Strongly Agree" = "7", "Agree" = "6", "Slightly Agree" = "5", "Neither Agree/Disagree" = "4",
                                                                "Slightly Disagree" = "3", "Disagree" = "2", "Strongly Disagree" = "1"))
df <- df %>% 
  mutate(friends_from_class_numeric = sel_friends_from_class)



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

### JUNIORS
#In-State
jun_IS_dont_belong <- jun_IS %>% filter(dont_belong_numeric >= 5)

jun_IS_belong_sum <- data.frame("Category" = c("Agree", "Neutral/Disagree"), "Counts" = c(nrow(jun_IS_dont_belong), nrow(jun_IS) - nrow(jun_IS_dont_belong)))

jun_IS_dont_belong_plot <- plot_ly(
  jun_IS_belong_sum,
  x=~Category,
  y=~Counts,
  type='bar',
  text=~Counts,
  textposition='auto'
)




# 
# jun_IS_belong_summary <- summarize(jun_IS_grouped_belong, agree = nrow(jun_IS_dont_belong), disagree = (nrow(jun_IS) - nrow(jun_IS_dont_belong)))#, total = nrow(jun_IS))
# 
# ggplot(jun_IS_belong_summary, aes(x = agree, y = disagree)) +
#   geom_bar(stat="identity", width=1)
# 
# fig <- plot_ly(juniors, x = ~countStrongAgree$, y = ~countSlightAgree, type = 'scatter')
# ggplot(df, aes(x = c("Slightly/Strongly Agree", "Neutral and Below"),
#                y = c(countStrongAgree + countSlightAgree, nrow(juniors) - (countStrongAgree + countSlightAgree)))
#        + geom_bar(stat="identity", width=1))
# 
# 

