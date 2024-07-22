using backend.DTOs;
using FluentValidation;

namespace backend.Validations;
// Object validator for CitizenDto
public class CitizenDtoValidator : AbstractValidator<CitizenDto>
{
    public CitizenDtoValidator()
    {
        RuleFor(x => x.GovernmentId)
            .NotNull().NotEmpty().WithMessage("Falta la cedula")
            .Matches(@"^[0-9]{11}$").WithMessage("La cedula no es valida, debe contener 11 numeros");

        RuleFor(x => x.Name)
            .NotEmpty().NotNull().WithMessage("Falta el nombre");

        RuleFor(x => x.Lastname)
            .NotEmpty().NotNull().WithMessage("Falta el apellido");

        RuleFor(x => x.Email)
            .NotEmpty().NotNull().WithMessage("Falta el correo");

        RuleFor(x => x.Password)
            .NotEmpty().NotEmpty().NotNull().WithMessage("Falta la contraseña");

        RuleFor(x => x.Vehicles)
            .NotNull() .WithMessage("Falta el vehiculo.");
    }
}
