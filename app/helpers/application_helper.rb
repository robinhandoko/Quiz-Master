module ApplicationHelper
  def render_question_info(question)
    case question.question_type
    when 1
      "Please select on of the following answer that you think is correct"
    when 2
      "You be able to select one or more correct answers"
    else
      ""
    end
  end
end
