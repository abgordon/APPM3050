clear                        % clear workspace
balance = 100;               % initial balance

while balance > 0

    balance = balance - input('Enter amount spent: ')

    if balance < 50
        disp('Warning, you are below 50')
    end

    disp('You still have some money left')

end
