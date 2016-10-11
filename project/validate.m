function [acc] = validate(Mdl, label, A, blockSize, lambda)

	X = prepareData(label, blockSize, 'test');
	S = learnCodes(X, A, lambda);

	prediction = predict(Mdl, S');

	label = int2str(label);
	acc = 0.0;
	for i = 1:size(prediction, 1)
		if strcmp(prediction{i, 1}, label)
			acc = acc + 1;
		end
	end

	acc = 100 * acc / size(X, 2);
end