function [acc] = validate(Mdl, label, A, lambda)

	X = prepareData(label, blockSize, 'test');
	S = learnCodes(X, A, lambda);

	prediction = predict(Mdl, S');

	acc = 0.0;
	for i = 1:size(prediction, 1)
		if prediction(i, 1) == label
			acc = acc + 1;
		end
	end

	acc = acc / size(X, 2);
end