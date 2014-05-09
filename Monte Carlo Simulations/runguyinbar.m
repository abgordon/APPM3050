data = zeros(11,1);

for i = 0:10
    p = guyinbar(i);
    data(i+1,1) = p;
end

data'
plot(data)
    