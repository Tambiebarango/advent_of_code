# frozen_string_literal: true

require_relative '../day1'

describe Day1 do
  describe 'load_numbers' do
    context 'when env is test' do
      it 'is accurate' do
        expected_list_1 = [3, 4, 2, 1, 3, 3]
        expected_list_2 = [4, 3, 5, 3, 9, 3]

        expect(described_class.load_numbers('test')).to contain_exactly(expected_list_1, expected_list_2)
      end
    end
  end

  describe Day1::Part2 do
    describe '.run' do
      context 'when env is test' do
        it 'returns correct result' do
          expect(described_class.run('test')).to eq(31)
        end
      end

      context 'when env is not test' do
        it 'returns correct result?' do
          expect(described_class.run('actual')).to eq(24643097)
        end
      end
    end

    describe '.similarity_score' do
      it 'returns correct result' do
        list1 = [3, 4, 2, 1, 3, 3]
        list2 = [4, 3, 5, 3, 9, 3]

        expect(described_class.similarity_score(list1, list2)).to eq(31)
      end
    end

    describe '.number_of_occurences' do
      let(:arr) { [4, 3, 5, 3, 9, 3] }

      it 'returns the correct answer for 3' do
        expect(described_class.number_of_occurences(3, arr)).to eq(3)
      end

      it 'returns the correct answer for 4' do
        expect(described_class.number_of_occurences(4, arr)).to eq(1)
      end

      it 'returns the correct answer for 2' do
        expect(described_class.number_of_occurences(2, arr)).to eq(0)
      end

      it 'returns the correct answer for 1' do
        expect(described_class.number_of_occurences(1, arr)).to eq(0)
      end

      it 'returns the correct answer for 3' do
        expect(described_class.number_of_occurences(3, arr)).to eq(3)
      end

      it 'returns the correct answer for 3' do
        expect(described_class.number_of_occurences(3, arr)).to eq(3)
      end
    end
  end

  describe Day1::Part1 do
    describe '.run' do
      context 'when env is test' do
        it 'returns correct result' do
          expect(described_class.run('test')).to eq(11)
        end
      end

      context 'when env is not test' do
        it 'returns correct result?' do # ✅
          expect(described_class.run('not_test')).to eq(2769675)
        end
      end
    end

    describe '.total_distance' do
      it 'is accurate' do
        list1 = [3, 4, 2, 1, 3, 3]
        list2 = [4, 3, 5, 3, 9, 3]

        expect(described_class.total_distance(list1, list2)).to eq(11)
      end
    end

    describe '.distance' do
      it 'returns the distance between the 1 and 3' do
        expect(described_class.distance(1, 3)).to eq(2)
        expect(described_class.distance(3, 1)).to eq(2)
      end

      it 'returns the distance between 2 and 3' do
        expect(described_class.distance(2, 3)).to eq(1)
        expect(described_class.distance(3, 2)).to eq(1)
      end

      it 'returns the distance between 3 and 3' do
        expect(described_class.distance(3, 3)).to eq(0)
      end

      it 'returns the distance between 3 and 4' do
        expect(described_class.distance(4, 3)).to eq(1)
        expect(described_class.distance(3, 4)).to eq(1)
      end

      it 'returns the distance between 3 and 5' do
        expect(described_class.distance(5, 3)).to eq(2)
        expect(described_class.distance(3, 5)).to eq(2)
      end

      it 'returns the distance between 4 and 9' do
        expect(described_class.distance(4, 9)).to eq(5)
        expect(described_class.distance(9, 4)).to eq(5)
      end
    end
  end
end
