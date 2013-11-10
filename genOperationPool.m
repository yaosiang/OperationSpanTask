function operationPool = genOperationPool

left = 2:9;
middle = 2:9;
right = 2:9;

operator1 = {'*', '/'};
operator2 = {'+', '-'};

operationPool = [];

for i = 1:length(right)
  for j = 1:length(operator2)
    for k = 1:length(middle)
      for m = 1:length(operator1)
        for n = 1:length(left)
          operationStr = strcat('(', num2str(left(n)), operator1{m}, num2str(middle(k)), ')', operator2{j}, num2str(right(i)));
          if (rem(eval(operationStr), 1) == 0) && (eval(operationStr) > 1) && (eval(operationStr) < 9)
            if (left(n) ~= middle(k)) && (right(i) ~= middle(k)) && (left(n) ~= right(i))
              operationPool = [operationPool; operationStr];
            end
          end
        end
      end
    end
  end
end