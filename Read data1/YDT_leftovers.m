values = 0.8:0.01:1.08;
leftovers = zeros(length(values),1);
for i=1:length(values)
    leftovers(i) = sum(yield_diff_thresh(data, values(i)));
end

figure
plot(0.8:0.01:1.1,ones(length(values)+2,1)*10,'--k')
hold on
plot(values,leftovers)
xlabel('Yield difference threshold')
ylabel('Number of varieties after elimination')
grid on
axis([0.8,1.1,0,180])