function [acc, c, prediction] = validate(Mdl, label, A, blockSize, lambda)

	X = prepareData(label, blockSize, 'test');
	S = learnCodes(X, A, lambda);

	prediction = predict(Mdl, S');

	acc = 0.0;
	for i = 1:size(prediction, 1)
		% if prediction(i, 1) == label
		if strcmp(prediction(i, 1), int2str(label))
			acc = acc + 1;
		end
	end
	c = size(X, 2);
end