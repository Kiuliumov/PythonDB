CREATE OR REPLACE FUNCTION fn_is_word_comprised(
    set_of_letters VARCHAR(50),
    word VARCHAR(50)
)
    RETURNS BOOLEAN
AS
$$
BEGIN
    RETURN TRIM(lower(word), lower(set_of_letters)) = '';
END
$$
    LANGUAGE plpgsql;