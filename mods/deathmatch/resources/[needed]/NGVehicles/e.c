/*
Isaac David Bermudez Lara
202014146
i.bermudezl

Diego Alejandro Camelo Giraldo
202011662
d.camelog

Juan Manuel Camacho Perez
202014177
jm.camachop1
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include <assert.h>

void pack(char* buffer, int* out)
{
	for (int i = 0; i < strlen(buffer); i++)
	{
		int offset = 8 * (3 - (i % 4));
		out[i / 4] += buffer[i] << offset;
	}
}

void pack2(char* buffer, int* outa)
{
	int s = strlen(buffer);
	int i = 0;

	int off_set = 0;

	int ind = 0;

	__asm {
	ini:
		mov eax, i
			cmp eax, s
			jge enda

			// int offset = 8 * (3 - (i%4)); 
			mov edx, 0
			mov eax, i
			mov ebx, 4
			div ebx

			mov ind, eax

			mov ebx, 3
			sub ebx, edx
			mov eax, 8
			mul ebx
			mov off_set, eax


			// buffer[i] << offset; *(buffer + i)
			mov esi, buffer
			mov ebx, i
			mov al, [esi + ebx]
			mov ecx, off_set
			shl eax, cl


			// out[i / 4] += buffer[i] << offset;
			mov esi, outa
			mov ebx, ind
			mov edx, [esi + ebx * 4]
			add edx, eax
			mov [esi + ebx * 4], edx

			inc i

			jmp ini
			enda :
	}
}

int main()
{
	char buffer[101];

	printf("Ingrese texto(maximo 100 caracteres):\n");
	scanf("%s", buffer);

	size_t buffer_size = strlen(buffer);

	int m_packer_size = ceil(buffer_size / 4.0);

	int* buffer_packer = (int*)calloc(m_packer_size, sizeof(int));

	//validation
	int* buffer_packer2 = (int*)calloc(m_packer_size, sizeof(int));

	pack(buffer, buffer_packer);

	//validation
	pack2(buffer, buffer_packer2);

	for (int i = 0; i < m_packer_size; i++)
	{
		// validation
		/*
		if (buffer_packer[i] == buffer_packer2[i])
		{
			printf("Funciona [%d] -> 0x%x   --   0x%x\n", i, buffer_packer[i], buffer_packer2[i]);
		}
		else
		{
			printf("Fallo [%d] -> 0x%x   --   0x%x\n", i, buffer_packer[i], buffer_packer2[i]);
		}
		*/

		printf("0x%X ", buffer_packer2[i]);
	}

	free(buffer_packer);

	return 0;
}
