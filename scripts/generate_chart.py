#!/usr/bin/python3
import sys
from pygooglechart import PieChart2D

title = sys.argv[1]
output_file = sys.argv[2]
data_str = sys.argv[3]
data = []
legend = []
labels = []
total = 0
for d in data_str.split(','):
    d_parts = d.split(":")
    legend.append(d_parts[0])
    val = int(d_parts[1])
    data.append(val)
    total = total + val
for d in data:
    labels.append("{:.2f}%".format(100 * d / total))

chart = PieChart2D(600, 200, title, legend)
chart.add_data(data)
chart.set_pie_labels(labels)
while True:
    try:
        chart.download(output_file)
    except:
        continue
    break
