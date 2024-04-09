library("ggplot2")

strain_names_all = c("JN.1", "JN.1.4", "BA.2.86.1", "JN.1.1", "EG.5.1.1")
strain_names = c("JN.1", "BA.2.86.1", "EG.5.1.1")
colorcode = c("#440154", "#21918c", "#fde725")

color_scale = c("JN.1"="#440154", "BA.2.86.1"= "#21918c", "EG.5.1.1"="#fde725")


strain_num = data.frame(year = c(rep(2023, 3), rep(2024, 3)), month = c(10,11,12,1,2,3),
    JN.1=rep(0, 6), BA.2.86.1=rep(0, 6), EG.5.1.1=rep(0, 6))

diff_df = data.frame(days=1:180, JN.1 = rep(0, 180), BA.2.86.1 = rep(0, 180), EG.5.1.1 = rep(0, 180))
for (i in 1:5)
{
    print(i)
    seqnames_f=file.path("/Users/px54/Documents/TB_software/manuscript_test/gisaid_23Oct_24Mar31", paste(c(i, strain_names_all[i], "seqnames.txt"), collapse="_"))
    con=file(seqnames_f,open="r")
    seqnames=readLines(con)
    if (i %in% c(1,2,4))
    {
        id = 1
    } else if (i==3)
    {
        id = 2
    } else
    {
        id = 3
    }
    for (seq in seqnames)
    {
        seqinfo = strsplit(seq, split="\\|")
        date = seqinfo[[1]][length(seqinfo[[1]])]
        dateinfo = strsplit(date, split="-")[[1]]
        date_diff = as.numeric(as.numeric(as.Date(date) - as.Date("2023-10-01"), unit="days"), units="days")
        diff_df[date_diff, id + 1] = diff_df[date_diff, id + 1] + 1
        #print(which(strain_num$year == as.integer(dateinfo[1])))
        #print(as.integer(dateinfo[1]))
        strain_num[which((strain_num$year == as.integer(dateinfo[1])) & (strain_num$month == as.integer(dateinfo[2]))), id + 2] = strain_num[which((strain_num$year == as.integer(dateinfo[1])) & (strain_num$month == as.integer(dateinfo[2]))),id+2] + 1
    }
    
}

p01 <- ggplot(sample_tb[which(sample_tb$V3 %in% c(0, 1, 5)),]) + 
  geom_histogram(aes(x = V1), alpha=0.5, fill="#440154", color="white", binwidth=10) + 
  theme_bw() + theme(panel.grid=element_blank(), axis.title.x = element_text(size = 16),
                     axis.text.x = element_text(size = 14),
                     axis.text.y = element_text(size = 14),
                     axis.title.y = element_text(size = 16),
                     legend.text=element_text(size=12),
                     legend.title=element_text(size=13), 
                     legend.position="none")  + labs(x="Days",y="Number of samples") +
  scale_x_continuous(breaks=c(62/2/2, 62/2 + (122-62)/2/2, 122/2 + (184-122)/2/2, 184/2 + (246-184)/2/2, 246/2 + (304-246)/2/2, 304/2+(365-304)/2/2), 
                     labels = c("2023-Oct", "2023-Nov", "2023-Dec", "2024-Jan", "2024-Feb", "2024-Mar")) #+ylim(0, 300)








strain_num$time=factor(c('2023-10', '2023-11', '2023-12', '2024-01', '2024-02', '2024-03'))
#strain_num$time = as.factor(strain_num$time)
#strain_num$time=factor(1:6)

write.csv(strain_num, "/Users/px54/Documents/TB_software/manuscript_test/gisaid_23Oct_24Mar31/strains_num_assembled.csv", row.names=F, quote=F)

print(strain_names[1])
p1 <- ggplot(strain_num) + geom_line(aes(x=time, y=JN.1, color=strain_names[1], group=1)) + # geom_line(aes(x=time, y=JN.1.4, color=strain_names[2], group=1)) +
    geom_line(aes(x=time, y=BA.2.86.1, color=strain_names[2], group=1)) + #geom_line(aes(x=time, y=JN.1.1, color=strain_names[4], group=1)) +
    geom_line(aes(x=time, y=EG.5.1.1, color=strain_names[3], group=1)) +
    scale_color_manual(name = "Strains", values = color_scale)  + theme_bw() + 
  theme(panel.grid=element_blank(), axis.title.x = element_text(size = 16),
  axis.text.x = element_text(size = 14),
  axis.text.y = element_text(size = 14),
  axis.title.y = element_text(size = 16),
  legend.text=element_text(size=12),
  legend.title=element_text(size=13)) +
   labs(x="Time",y="Samples")
ggsave("/Users/px54/Documents/TB_software/manuscript_test/gisaid_23Oct_24Mar31/strains_num_assembled.pdf", plot = p1, width = 8, height = 5, dpi = 300)

strain_num_norm = strain_num
for (i in 1:6)
{
    strain_num_norm[i, 3:5] = strain_num[i, 3:5] / sum(strain_num[i, 3:5])
}

p2 <- ggplot(strain_num_norm) + geom_line(aes(x=time, y=JN.1, color=strain_names[1], group=1)) + #geom_line(aes(x=time, y=JN.1.4, color=strain_names[2], group=1)) +
    geom_line(aes(x=time, y=BA.2.86.1, color=strain_names[2], group=1)) + #geom_line(aes(x=time, y=JN.1.1, color=strain_names[4], group=1)) +
    geom_line(aes(x=time, y=EG.5.1.1, color=strain_names[3], group=1)) +
    scale_color_manual(name = "Strains", values = color_scale)  + theme_bw() + 
  theme(panel.grid=element_blank(), axis.title.x = element_text(size = 16),
  axis.text.x = element_text(size = 14),
  axis.text.y = element_text(size = 14),
  axis.title.y = element_text(size = 16),
  legend.text=element_text(size=12),
  legend.title=element_text(size=13)) +
   labs(x="Time",y="Number of Samples")
ggsave("/Users/px54/Documents/TB_software/manuscript_test/gisaid_23Oct_24Mar31/strains_pct_assmebled.pdf", plot = p2, width = 4, height = 3.5, dpi = 300)


