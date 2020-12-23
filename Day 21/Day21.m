%% Import data
clear
clc

inputArray = importfile('input.txt');

%% Parse data
tic
foodArray = cell(length(inputArray), 2);
allergensArray = {};
ingredientsArray = {};
ingrCount = 0;

for i = 1:length(inputArray)
    food = inputArray{i};
    food = split(food, "(");
    
    ingredients = food{1};
    allergens = food{2};
    
    ingredients = split(ingredients, " ");
    ingredients = ingredients(1:end-1);
    allergens = split(allergens, [" ", ", ", ")"]);
    allergens = allergens(2:end-1);
    
    ingrCount = ingrCount + length(ingredients);
    
    foodArray{i, 1} = ingredients;
    foodArray{i, 2} = allergens;
    
    allergensArray = [allergensArray; allergens];
    ingredientsArray = [ingredientsArray; ingredients];
end
allergensArray = unique(allergensArray);
ingredientsArray = unique(ingredientsArray);

%% Map ingredients to allergens
allergensMap = cell(length(allergensArray), 2);

for i = 1:length(allergensArray)
    allergen = allergensArray{i};
    allergensMap{i,1} = allergen;
    ctr = 0;
    
    for j = 1:length(inputArray)
        allergens = foodArray{j,2};
        
        if ismember(allergen, allergens)
            ingredients = foodArray{j,1};
            ctr = ctr+1;
            
            if ctr == 1
                ingredientsList = ingredients;
            else
                ingredientsList = intersect(ingredientsList, ingredients);
            end
        end       
    end   
    allergensMap{i,2} = ingredientsList;
end

%% Calculate safe ingredients occurences
allergensFound = unique(vertcat(allergensMap{:,2}));
setdiff(ingredientsArray,allergensFound);
part1 = 0;

for i = 1:length(allergensFound)
    allergen = allergensFound{i};
    
    for j = 1:length(inputArray)
        ingredients = foodArray{j,1};
        occurences = sum(strcmp(ingredients, allergen));
        part1 = part1 + occurences;
    end
end
part1 = ingrCount - part1 % safe = total - unsafe
toc

%% Match allergens and their names
matchingArray = zeros(length(allergensFound));
allergensFound = string(allergensFound);

for i = 1:length(allergensFound)
   opts = string(allergensMap{i,2});
   
   for j = 1:length(opts)
        idx = allergensFound == opts{j};
        matchingArray(idx,i) = 1;
   end
end
matching = dmperm(matchingArray);
part2 = join(allergensFound(matching),',')
toc